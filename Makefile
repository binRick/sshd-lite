.PHONY: default all dep publish clean linux64 linuxarm64 darwin64 darwinarm64 win64

default: all

all: dep
	a
a: 
	go build
	ansi --green --bold "make deps_ok"
	ansi --yellow --bold "make deps_extra"	
	rsync sshd-lite /opt/vpntech-binaries/x86_64/.
#	@$$GOPATH/bin/goreleaser  -f .github/goreleaser.yml build --snapshot --rm-dist

dep:
	@go install github.com/goreleaser/goreleaser@latest
	@go get -v -d ./...
	@go get -u all
	@go mod tidy
	@go fmt

publish: dep
	@$$GOPATH/bin/goreleaser  -f .github/goreleaser.yml release --rm-dist

clean:
	@rm -rf dist

linux64:
	@GOOS=linux GOARCH=amd64 $$GOPATH/bin/goreleaser  -f .github/goreleaser.yml build --snapshot --rm-dist --single-target

linuxarm64:
	@GOOS=linux GOARCH=arm64 $$GOPATH/bin/goreleaser  -f .github/goreleaser.yml build --snapshot --rm-dist --single-target

darwin64:
	@GOOS=darwin GOARCH=amd64 $$GOPATH/bin/goreleaser  -f .github/goreleaser.yml build --snapshot --rm-dist --single-target

darwinarm64:
	@GOOS=darwin GOARCH=arm64 $$GOPATH/bin/goreleaser  -f .github/goreleaser.yml build --snapshot --rm-dist --single-target

win64: 
	@GOOS=windows GOARCH=amd64 $$GOPATH/bin/goreleaser  -f .github/goreleaser.yml build --snapshot --rm-dist --single-target
