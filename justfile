switch:
	-rm ~/.config/mimeapps.list
	-rm ~/.local/share/mimeapps.list
	sudo nixos-rebuild switch --flake .

update:
	-rm ~/.config/mimeapps.list
	-rm ~/.local/share/mimeapps.list
	nix flake update
	sudo nixos-rebuild switch --flake .

rekey:
	op read "op://Personal/ymqirvvpvyvjwq4v6i5j5xmjrq/public key" --out-file ~/.ssh/id_ed25519.pub
	op read "op://Personal/ymqirvvpvyvjwq4v6i5j5xmjrq/private key" --out-file ~/.ssh/id_ed25519
	cd secrets && agenix -r
	rm ~/.ssh/id_ed25519*
