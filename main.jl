using DataFrames

test = readtable("C:\\Users\\vince_000\\Dropbox (Personal)\\Documents\\MIT\\UROP\\Adversarial Examples - Russ Tedrake\\mnist_abr_test.csv", header=false)
testlabels = readtable("C:\\Users\\vince_000\\Dropbox (Personal)\\Documents\\MIT\\UROP\\Adversarial Examples - Russ Tedrake\\mnist_abr_testlabels.csv", header=false)
train = readtable("C:\\Users\\vince_000\\Dropbox (Personal)\\Documents\\MIT\\UROP\\Adversarial Examples - Russ Tedrake\\mnist_abr_train.csv", header=false)
trainlabels = readtable("C:\\Users\\vince_000\\Dropbox (Personal)\\Documents\\MIT\\UROP\\Adversarial Examples - Russ Tedrake\\mnist_abr_trainlabels.csv", header=false)

possible_labels = [0 1 2 3 4 5 6 7 8 9]
x_size = 784
num_labels = length(possible_labels)
num_train_examples = size(trainlabels, 1)

Xt = transpose(array(train))/255
Yt = broadcast(==,array(trainlabels), [0 1 2 3 4 5 6 7 8 9])
Yt = map(x -> convert(Float64,x), Yt)
Dt = \(Xt,Yt)

D = transpose(Dt)
