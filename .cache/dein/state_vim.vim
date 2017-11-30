if g:dein#_cache_version != 100 | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/home/vagrant/.vimrc', '/home/vagrant/.vim/rc/dein.toml', '/home/vagrant/.vim/rc/dein_lazy.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/home/vagrant/.cache/dein'
let g:dein#_runtime_path = '/home/vagrant/.cache/dein/.cache/.vimrc/.dein'
let g:dein#_cache_path = '/home/vagrant/.cache/dein/.cache/.vimrc'
let &runtimepath = '/home/vagrant/.cache/dein/repos/github.com/Shougo/dein.vim/,/home/vagrant/.vim,/usr/local/share/vim/vimfiles,/home/vagrant/.cache/dein/repos/github.com/Shougo/dein.vim,/home/vagrant/.cache/dein/.cache/.vimrc/.dein,/usr/local/share/vim/vim74,/home/vagrant/.cache/dein/.cache/.vimrc/.dein/after,/usr/local/share/vim/vimfiles/after,/home/vagrant/.vim/after'
