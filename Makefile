exec = td
dest = /usr/local/bin

install:
	cp $(exec) $(dest)

link:
	ln -s $(realpath $(exec)) $(dest)

uninstall:
	rm $(dest)/$(exec)
