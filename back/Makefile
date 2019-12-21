.SILENT:

API_DOC_FILE=./docs/api.md

.PHONY: all
all: build graph stat-complexity generate-docs

.PHONY: build
build:
	echo 'stack build'; \
	stack build

.PHONY: graph
graph:
	echo '🔀 exporting dependency graph to ./data/modules.pdf and ./data/modules.png'; \
	find src -name "*.hs" | xargs graphmod -q | dot -Tpdf > data/modules.pdf; \
	find src -name "*.hs" | xargs graphmod -q | dot -Tpng -Gdpi=300 > data/modules.png

.PHONY: stat-complexity
stat-complexity:
	echo '➿ Complexity analysis stats:\n'; \
	homplexity-cli app/Main.hs src/ && echo '\n'

.PHONY: generate-docs
generate-docs:
	echo '📚 Generating docs...'; \
	stack runghc src/App/Util/GenerateApiDocs.hs $(API_DOC_FILE); \
	echo '👉 Exported to $(API_DOC_FILE)'

.PHONY: run
run:
	echo 'running...'; \
	stack exec back-exe

.PHONY: init-db
init-db: reset-db migrate-db seeds-db

.PHONY: reset-db
reset-db:
	./db/reset.sh

.PHONY: migrate-db
migrate-db:
	./db/migrate.sh

.PHONY: seeds-db
seeds-db:
	./db/seeds.sh

.PHONY: dump-schema
dump-schema:
	./db/dump.sh
