mkdir -p ~/.config/nvim/plugin
mkdir -p ~/.config/nvim/after/plugin
mkdir -p ~/.config/nvim/lua/config

for f in `find **/*.(vim|nvim|lua)`; do
  rm -rf ~/.config/nvim/$f
  ln -sv ~/dotfiles/nvim/$f ~/.config/nvim/$f
done
