import numpy as np
def sigmoid(x):
    return 1 / (1 + np.exp(-x))
def sigmoid_prime(x):
    return sigmoid(x) * (1 - sigmoid(x))
def maxi(x):
    if x>0:
        return x
    else:
        return 0
def maxi_prime(x):
    if x>0:
        return 1
    else:
        return 0
weights = [np.array([(0.7, 0.2, 0.7),(0.8, 0.3, 0.6)]), np.array([(0.2, 0.4)])]
y = 1
x = np.array([ 0.0, 1.0, 1.0])
inner_z = weights[0].dot(x)
inner_a = np.array([maxi(inner_z[0]), sigmoid(inner_z[1])])
print (inner_a, inner_z[0], inner_z[1])
z_out = weights[1].dot(inner_a)
y_out = sigmoid(z_out)

err_out = (y_out-y)*sigmoid_prime(z_out)
print(err_out)
err_inner = weights[1].T.dot(err_out)*np.array([maxi_prime(inner_z[0]), sigmoid_prime(inner_z[1])])
d_w = x[2]*err_inner
print(d_w)