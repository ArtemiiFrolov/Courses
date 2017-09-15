import numpy as np
def sigmoid(x):
    return 1 / (1 + np.exp(-x))
def sigmoid_prime(x):
    return sigmoid(x) * (1 - sigmoid(x))
weights = [np.array([(0.2, 0.9, 0.6),(0.2, 0.3, 0.7)]), np.array([(0.2, 0.5)])]
y = 1
x = np.array([ 15.0, 5.0, 15.0])
inner_z = weights[0].dot(x)
inner_a = sigmoid(inner_z)
z_out = weights[1].dot( inner_a)
y_out = sigmoid(z_out)
err_out = (y_out-y)*sigmoid_prime(z_out)
err_inner = weights[1].T.dot(err_out)*sigmoid_prime(inner_z)
d_w = x[2]*err_inner
print(d_w)