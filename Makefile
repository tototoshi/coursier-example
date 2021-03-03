HEAD := $(shell git rev-parse HEAD)

.PHONY: test clean

cs:
	curl -fLo cs https://git.io/coursier-cli-"$(shell uname | tr LD ld)"
	chmod +x ./cs

test: cs clean
	sbt publishLocal

	./cs bootstrap com.github.tototoshi::cshello:0.1.0-SNAPSHOT -o cshello -f
	./cshello | grep $(HEAD)

	./cs bootstrap com.github.tototoshi::cshello:0.1.0-SNAPSHOT -o cshello --standalone -f
	./cshello | grep $(HEAD)

	./cs launch com.github.tototoshi::cshello:0.1.0-SNAPSHOT -M com.github.tototoshi.cshello.Main | grep $(HEAD)

clean:
	sbt clean
	rm -f cshello
