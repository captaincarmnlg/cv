OUTPUT_DIR = output
INPUT_FILE := ./shared/combined.md
LANGUAGES := en nl


all: cv resume

cv:
	mkdir -p $(OUTPUT_DIR)
	$(foreach lang,$(LANGUAGES),$(MAKE) $(lang)-cv.pdf;)

resume:
	mkdir -p $(OUTPUT_DIR)
	$(foreach lang,$(LANGUAGES),$(MAKE) $(lang)-resume.pdf;)

%-resume.pdf:
	(for file in ./shared/*.md; do cat "$$file"; echo -e "\n"; done) | pandoc --pdf-engine=xelatex --metadata=lang=$* --metadata-file=resume.yaml --lua-filter=filter-ex.lua --lua-filter=filter-lang.lua --lua-filter columns.lua -f markdown+yaml_metadata_block --template templates/jb2-modern.latex -o $(OUTPUT_DIR)/$@


%-cv.pdf:
	(for file in ./shared/*.md; do cat "$$file"; echo -e "\n"; done) | pandoc --pdf-engine=xelatex --metadata=lang=$* --metadata-file=cv.yaml --lua-filter=filter-ex.lua --lua-filter=filter-lang.lua -f markdown+yaml_metadata_block --template templates/jb2-modern.latex -o $(OUTPUT_DIR)/$@
