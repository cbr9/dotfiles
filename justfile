switch:
	-rm ~/.mozilla/firefox/default/search.json.mozlz4.backup
	-rm ~/.config/mimeapps.list
	-rm ~/.local/share/mimeapps.list
	sudo nixos-rebuild switch --flake .
	awesome-client "awesome.restart()"

rekey:
	op read "op://Personal/ymqirvvpvyvjwq4v6i5j5xmjrq/public key" --out-file ~/.ssh/id_ed25519.pub
	op read "op://Personal/ymqirvvpvyvjwq4v6i5j5xmjrq/private key" --out-file ~/.ssh/id_ed25519
	cd secrets && agenix -r
	rm ~/.ssh/id_ed25519*
