import numpy as np
def sigmoid(x):
    return 1 / (1 + np.exp(-x))
def sigmoid_prime(x):
    return sigmoid(x) * (1 - sigmoid(x))
weights = [np.array([(2,2,2),(2,2,2)]), np.array([(1,1)])]
y = 1
x = np.array([ 0, 1, 2])
inner_z = weights[0].dot(x)
inner_a = sigmoid(inner_z)
z_out = weights[1].dot( inner_a)
y_out = sigmoid(z_out)
err_out = (y_out-y)*sigmoid_prime(z_out)
err_inner = weights[1].T.dot(err_out)*sigmoid_prime(inner_z)
d_w = x[2]*err_inner
print(d_w)