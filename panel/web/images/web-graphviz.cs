#!/usr/bin/env python

####+BEGIN: b:prog:file/particulars :authors ("./inserts/authors-mb.org")
""" #+begin_org
* *[[elisp:(org-cycle)][| Particulars |]]* :: Authors, version
** This File: /bisos/git/auth/bxRepos/bisos-pip/binsprep/py3/bin/exmpl-func-binsPrep.cs
** Authors: Mohsen BANAN, http://mohsen.banan.1.byname.net/contact
#+end_org """
####+END:

""" #+begin_org
* Panel::  [[file:/bisos/panels/bisos-apps/lcnt/lcntScreencasting/subTitles/_nodeBase_/fullUsagePanel-en.org]]
* Overview and Relevant Pointers
#+end_org """

from bisos import b
from bisos.b import cs

import graphviz

from bisos.graphviz import graphvizSeed
ng = graphvizSeed.namedGraph


####+BEGIN: b:py3:cs:func/typing :funcName "web_nginxDrfReact" :funcType "Typed" :deco "track"
""" #+begin_org
*  _[[elisp:(blee:menu-sel:outline:popupMenu)][±]]_ _[[elisp:(blee:menu-sel:navigation:popupMenu)][Ξ]]_ [[elisp:(outline-show-branches+toggle)][|=]] [[elisp:(bx:orgm:indirectBufOther)][|>]] *[[elisp:(blee:ppmm:org-mode-toggle)][|N]]*  F-T-Typed  [[elisp:(outline-show-subtree+toggle)][||]] /web_nginxDrfReact/  deco=track  [[elisp:(org-cycle)][| ]]
#+end_org """
@cs.track(fnLoc=True, fnEntry=True, fnExit=True)
def web_nginxDrfReact(
####+END:
) -> graphviz.Digraph:
    """ #+begin_org
** [[elisp:(org-cycle)][| *DocStr | ]
    #+end_org """

    # Initialize the diagram
    dot = graphviz.Digraph('MultiAppArchitecture', comment='Nginx Gunicorn Django React Stack')
    dot.attr(rankdir='LR', size='12,8', fontname='Arial')

    # Node styling defaults
    dot.attr('node', shape='box', style='filled,rounded', fontname='Arial', fontsize='10')

    # --- LEGEND ---
    with dot.subgraph(name='cluster_legend') as l:
        l.attr(label='Legend', fontsize='12', style='dotted')
        l.node('l1', 'Systemd Daemon', fillcolor='#ff9999')
        l.node('l2', 'Systemd Socket', fillcolor='#ffcc00')
        l.node('l3', 'React (Static)', fillcolor='#c2f0c2')
        l.node('l4', 'Django (Logic)', fillcolor='#add8e6')

    # --- CORE INFRASTRUCTURE ---
    dot.node('User', 'User\n(Browser)', shape='ellipse', fillcolor='white')
    dot.node('Nginx', 'Nginx\n(systemd daemon)', fillcolor='#ff9999')
    dot.edge('User', 'Nginx', label=' HTTP/S')

    # --- APPLICATION 1 ---
    with dot.subgraph(name='cluster_app1') as c1:
        c1.attr(label='Application Stack 1', style='dashed', color='grey')
        c1.node('React1', 'React UI 1\n(Static Files)', fillcolor='#c2f0c2')
        c1.node('Socket1', 'systemd socket 1\n(/run/app1.sock)', fillcolor='#ffcc00')
        c1.node('Gunicorn1', 'Gunicorn 1\n(systemd daemon)', fillcolor='#ff9999')
        c1.node('Django1', 'Django 1\n(App Logic)', fillcolor='#add8e6')

        # Internal flow
        dot.edge('Nginx', 'React1', label=' direct serve', style='dotted')
        dot.edge('Nginx', 'Socket1', label=' proxy_pass')
        dot.edge('Socket1', 'Gunicorn1')
        dot.edge('Gunicorn1', 'Django1')

    # --- APPLICATION 2 ---
    with dot.subgraph(name='cluster_app2') as c2:
        c2.attr(label='Application Stack 2', style='dashed', color='grey')
        c2.node('React2', 'React UI 2\n(Static Files)', fillcolor='#c2f0c2')
        c2.node('Socket2', 'systemd socket 2\n(/run/app2.sock)', fillcolor='#ffcc00')
        c2.node('Gunicorn2', 'Gunicorn 2\n(systemd daemon)', fillcolor='#ff9999')
        c2.node('Django2', 'Django 2\n(App Logic)', fillcolor='#add8e6')

        # Internal flow
        dot.edge('Nginx', 'React2', label=' direct serve', style='dotted')
        dot.edge('Nginx', 'Socket2', label=' proxy_pass')
        dot.edge('Socket2', 'Gunicorn2')
        dot.edge('Gunicorn2', 'Django2')


    return dot


####+BEGIN: b:py3:cs:orgItem/basic :type "=Seed Setup= " :title "*Common Facilities*" :comment "General"
""" #+begin_org
*  _[[elisp:(blee:menu-sel:outline:popupMenu)][±]]_ _[[elisp:(blee:menu-sel:navigation:popupMenu)][Ξ]]_ [[elisp:(outline-show-branches+toggle)][|=]] [[elisp:(bx:orgm:indirectBufOther)][|>]] *[[elisp:(blee:ppmm:org-mode-toggle)][|N]]*  =Seed Setup=  [[elisp:(outline-show-subtree+toggle)][||]] *Common Facilities* General  [[elisp:(org-cycle)][| ]]
#+end_org """
####+END:


namedGraphsList = [
    ng("web_nginxDrfReact", func=web_nginxDrfReact),   #
]


graphvizSeed.setup(
    seedType="common",
    namedGraphsList=namedGraphsList,
    # examplesHook=qmail_binsPrep.examples_csu,
)
