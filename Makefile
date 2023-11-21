
pack:
	@bash scripts/pack.sh

clean:
	rm -r dist

test:
	@mkdir -p dist
	act -e .github/workflows/tag.json --artifact-server-path dist

bump:
	@bash scripts/version.sh $(version)
