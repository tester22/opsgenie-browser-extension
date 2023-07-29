.PHONY: firefox
firefox:
	@rm -rf firefox
	@cp -r chrome firefox
	@jq '. + {"background": {"scripts": ["background.js"]},"browser_specific_settings": {"gecko": {"id": "opsgenie-notifier@jkroepke.de","strict_min_version": "115.0"}}}' chrome/manifest.json > firefox/manifest.json
	@git add firefox

node_modules:
	npm install

lint: node_modules
	npm run lint

.PHONY: clean
clean:
	rm -f */*.zip

.PHONY: package
package: clean firefox chrome/chrome.zip firefox/firefox.zip

firefox/firefox.zip:
	cd firefox && zip -r firefox.zip *

chrome/chrome.zip:
	cd chrome && zip -r chrome.zip *
