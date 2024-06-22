run:
	swift run

build:
	swift build

clean:
	rm -rf .build
	rm *.o
	rm *.d
	rm *.swiftdeps*
	rm Package.resolved
