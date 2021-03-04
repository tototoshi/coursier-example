HEAD := $(shell git rev-parse HEAD)
CS := $(shell pwd)/cs

.PHONY: test clean

$(CS):
	curl -fLo cs https://git.io/coursier-cli-"$(shell uname | tr LD ld)"
	chmod +x $(CS)

test: clean $(CS)
	sbt publishLocal

	$(CS) bootstrap com.github.tototoshi::cshello:0.1.0-SNAPSHOT -o cshello -f
	./cshello | grep $(HEAD)

	$(CS) bootstrap com.github.tototoshi::cshello:0.1.0-SNAPSHOT -o cshello --standalone -f
	./cshello | grep $(HEAD)

	$(CS) launch com.github.tototoshi::cshello:0.1.0-SNAPSHOT -M com.github.tototoshi.cshello.Main | grep $(HEAD)

clean:
	sbt clean
	rm -f $(CS)
	rm -f cshello
