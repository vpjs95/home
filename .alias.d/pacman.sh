alias aur='yaourt'
alias pms='pacman -Ss'
alias pmi='sudo pacman -S --needed'
alias pmr='sudo pacman -Rc'
alias pmu='yaourt -Syu --aur --devel'
alias pmR='pmr $(pacman -Qdt | sed "s/ .*//")'
alias pmq='pacman -Qi'
alias pml='pacman -Ql'
alias pmf='pacman -Qo'
