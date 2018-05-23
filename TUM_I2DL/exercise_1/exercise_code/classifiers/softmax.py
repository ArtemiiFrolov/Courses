"""Linear Softmax Classifier."""
# pylint: disable=invalid-name
import numpy as np

from .linear_classifier import LinearClassifier


def cross_entropoy_loss_naive(W, X, y, reg):
    """
    Cross-entropy loss function, naive implementation (with loops)

    Inputs have dimension D, there are C classes, and we operate on minibatches
    of N examples.

    Inputs:
    - W: A numpy array of shape (D, C) containing weights.
    - X: A numpy array of shape (N, D) containing a minibatch of data.
    - y: A numpy array of shape (N,) containing training labels; y[i] = c means
      that X[i] has label c, where 0 <= c < C.
    - reg: (float) regularization strength

    Returns a tuple of:
    - loss as single float
    - gradient with respect to weights W; an array of same shape as W
    """
    # pylint: disable=too-many-locals
    # Initialize the loss and gradient to zero.
    loss = 0.0
    loss2 = 0.0
    dW = np.zeros_like(W)
    y_cap = X.dot(W)
    N = y_cap.shape[0]
    ############################################################################
    # TODO: Compute the cross-entropy loss and its gradient using explicit     #
    # loops. Store the loss in loss and the gradient in dW. If you are not     #
    # careful here, it is easy to run into numeric instability. Don't forget   #
    # the regularization!                                                      #
    ############################################################################
    for i, val in enumerate(y_cap):
        val = np.exp(val)/(np.sum(np.exp(val)))
        loss -= np.log(val[y[i]])
        val[y[i]] -= 1
        dW += np.dot(np.expand_dims(X[i], axis=1) , np.expand_dims(val, axis=1).T)/N
    loss += reg*np.sum(W*W)
    dW += 2*reg*W
    ############################################################################
    #                          END OF YOUR CODE                                #
    ############################################################################
    return loss/N, dW


def cross_entropoy_loss_vectorized(W, X, y, reg):
    """
    Cross-entropy loss function, vectorized version.

    Inputs and outputs are the same as in cross_entropoy_loss_naive.
    """
    # Initialize the loss and gradient to zero.
    loss = 0.0
    dW = np.zeros_like(W)
    y_cap = X.dot(W)
    N = y_cap.shape[0]
    ############################################################################
    # TODO: Compute the cross-entropy loss and its gradient without explicit   #
    # loops. Store the loss in loss and the gradient in dW. If you are not     #
    # careful here, it is easy to run into numeric instability. Don't forget   #
    # the regularization!                                                      #
    ############################################################################
    y_cap = y_cap - np.expand_dims(np.max(y_cap,axis=1), axis=1)
    y_cap = np.exp(y_cap)
    y_cap = y_cap/(np.expand_dims(np.sum(y_cap, axis=1), axis=1))
    loss = -np.sum(np.log(y_cap[np.arange(N), y]+1e-8))/N
    loss += reg * np.sum(W*W)
    y_cap[np.arange(N), y] = y_cap[np.arange(N), y]-1
    dW = X.T.dot(y_cap)/N + 2*reg*W
    ############################################################################
    #                          END OF YOUR CODE                                #
    ############################################################################

    return loss, dW


class SoftmaxClassifier(LinearClassifier):
    """The softmax classifier which uses the cross-entropy loss."""

    def loss(self, X_batch, y_batch, reg):
        return cross_entropoy_loss_vectorized(self.W, X_batch, y_batch, reg)


def softmax_hyperparameter_tuning(X_train, y_train, X_val, y_val):
    # results is dictionary mapping tuples of the form
    # (learning_rate, regularization_strength) to tuples of the form
    # (training_accuracy, validation_accuracy). The accuracy is simply the
    # fraction of data points that are correctly classified.
    results = {}
    best_val = -1
    best_softmax = None
    all_classifiers = []
    #learning_rates = np.arange(5e-6, 5e-5, 1e-6)
    #regularization_strengths = np.arange(50, 150, 10)
    learning_rates = np.arange(5e-7, 1e-6, 5e-8)
    regularization_strengths = [80, 100, 120]

    ############################################################################
    # TODO:                                                                    #
    # Write code that chooses the best hyperparameters by tuning on the        #
    # validation set. For each combination of hyperparameters, train a         #
    # classifier on the training set, compute its accuracy on the training and #
    # validation sets, and  store these numbers in the results dictionary.     #
    # In addition, store the best validation accuracy in best_val and the      #
    # Softmax object that achieves this accuracy in best_softmax.              #                                      #
    #                                                                          #
    # Hint: You should use a small value for num_iters as you develop your     #
    # validation code so that the classifiers don't take much time to train;   # 
    # once you are confident that your validation code works, you should rerun #
    # the validation code with a larger value for num_iters.                   #
    ############################################################################
    N_t = len(y_train)
    N_v = len(y_val)
    for rate in learning_rates:
        for reg in regularization_strengths:
            classifier = SoftmaxClassifier()
            losses = classifier.train(X_train, y_train, rate, reg, num_iters=5000)
            #print(rate,reg,losses[-1])
            y_t = classifier.predict(X_train)
            y_v = classifier.predict(X_val)
            acc_t = np.count_nonzero(y_t == y_train)/N_t
            acc_v = np.count_nonzero(y_v == y_val)/N_v
            results[(rate, reg)] = (acc_t, acc_v)
            if best_val < acc_v:
                best_val = acc_v
                best_softmax = classifier
                print("Best ", end="")
            all_classifiers.append((classifier, acc_v))
            print(rate, reg)
    ############################################################################
    #                              END OF YOUR CODE                            #
    ############################################################################
        
    # Print out results.
    for (lr, reg) in sorted(results):
        train_accuracy, val_accuracy = results[(lr, reg)]
        print('lr %e reg %e train accuracy: %f val accuracy: %f' % (
              lr, reg, train_accuracy, val_accuracy))
        
    print('best validation accuracy achieved during validation: %f' % best_val)

    return best_softmax, results, all_classifiers
