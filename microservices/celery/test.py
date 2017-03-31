from tasks import add

for i in range(1, 100000):
	add.delay(i, i)