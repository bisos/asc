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


####+BEGIN: b:py3:cs:func/typing :funcName "mtdtConceptsGraph" :funcType "Typed" :deco "track"
""" #+begin_org
*  _[[elisp:(blee:menu-sel:outline:popupMenu)][±]]_ _[[elisp:(blee:menu-sel:navigation:popupMenu)][Ξ]]_ [[elisp:(outline-show-branches+toggle)][|=]] [[elisp:(bx:orgm:indirectBufOther)][|>]] *[[elisp:(blee:ppmm:org-mode-toggle)][|N]]*  F-T-Typed  [[elisp:(outline-show-subtree+toggle)][||]] /mtdtConceptsGraph/  deco=track  [[elisp:(org-cycle)][| ]]
#+end_org """
@cs.track(fnLoc=True, fnEntry=True, fnExit=True)
def mtdtConceptsGraph(
####+END:
) -> graphviz.Digraph:
    """ #+begin_org
** [[elisp:(org-cycle)][| *DocStr | ]
    #+end_org """

    dot = graphviz.Digraph(
        comment='MTDT Concepts',
        graph_attr={'rankdir':'LR'},
    )

    # 1- Gnu-Emacs
    dot.node('MTDT', 'MTDT\nConcepts', shape='circle', style='filled', fillcolor='darkseagreen3')

    # 1.1  1.2 1.3 - Redist Types
    dot.node('SelectedCompositionFwrk', 'Selected Composition Framework', shape='cylinder', style='filled', fillcolor='green')
    dot.node('MailingFile', 'MailingFile', shape='cylinder', style='filled', fillcolor='darksalmon')
    dot.node('Interactive', 'Interactive Invokations', shape='cylinder', style='filled', fillcolor='darksalmon')
    dot.node('SendExtent', 'Send Extent', shape='cylinder', style='filled', fillcolor='darksalmon')
    dot.node('OorR', 'Orig Or Recipients', shape='cylinder', style='filled', fillcolor='darksalmon')
    dot.node('AddressBook', 'Address Book', shape='cylinder', style='filled', fillcolor='darksalmon')
    dot.node('Names', 'Names', shape='cylinder', style='filled', fillcolor='darksalmon')
    dot.node('Distributions', 'Distributions', shape='cylinder', style='filled', fillcolor='darksalmon')
    dot.node('Tracking', 'Tracking', shape='cylinder', style='filled', fillcolor='darksalmon')

    # 1.1.1
    dot.node('PlainText', 'PlainText', style='filled', fillcolor='green')
    dot.node('OrgMsg', 'OrgMsg', style='filled', fillcolor='green')
    dot.node('LaTeX', 'LaTeX', style='filled', fillcolor='green')
    dot.node('Html', 'Html', style='filled', fillcolor='green')
    dot.node('WithSelMailing', 'With Sel Mailing', style='filled', fillcolor='green')

    # 1.2.1
    dot.node('TemplateFile', 'TemplateFile', style='filled', fillcolor='green')
    dot.node('MailingCmnd', 'Mailing Command', style='filled', fillcolor='green')
    dot.node('SelectedMailing', 'Selected Mailing', style='filled', fillcolor='green')

    # 1.3.1  1.3.2
    dot.node('Gnus', 'Gnus', style='filled', fillcolor='green')
    dot.node('MtdtMenu', 'MTDT Menu', style='filled', fillcolor='green')
    dot.node('MailingMenu', 'Mailing Menu', style='filled', fillcolor='green')
    dot.node('DistMenu', 'Distribution Menu', style='filled', fillcolor='green')

    #
    dot.node('CompositionModel', 'Composition Model', style='filled', fillcolor='green')
    dot.node('NativeComposition', 'Native Composition', style='filled', fillcolor='green')
    dot.node('ExternalComposition', 'External Composition', style='filled', fillcolor='green')

    dot.node('ContentCustomization', 'Content Customization', style='filled', fillcolor='green')

    # 1.2.1.1
    dot.node('SendExtent', 'Send Extent', style='filled', fillcolor='green')
    dot.node('doSend', 'doSend', style='filled', fillcolor='green')
    dot.node('unsentBuf', 'unsentBuffer', style='filled', fillcolor='green')

    # 1.3.1.1  1.3.2.1
    dot.node('Recipients', 'Recipients', style='filled', fillcolor='darksalmon')
    dot.node('RecipientsList', 'Recipients List', style='filled', fillcolor='darksalmon')
    dot.node('RecipientsListForm', 'Recipients List Form',  style='filled', fillcolor='darksalmon')
    dot.node('RecipientsListFormFile', 'Recipients List Form File',  style='filled', fillcolor='darksalmon')

    # dot.node('bbdb2', 'bbdb2', style='filled', fillcolor='darksalmon')
    dot.node('bbdb3', 'bbdb3', style='filled', fillcolor='darksalmon')

    dot.node('NamesFile', 'namesFile', style='filled', fillcolor='darksalmon')

    dot.node('DistNamesFile', 'distNamesFile', style='filled', fillcolor='darksalmon')

    dot.node('LogFile', 'logFile', style='filled', fillcolor='darksalmon')

    dot.node('sendWithExtent', 'sendWithExtent', style='filled', fillcolor='darksalmon')
    dot.node('unsentBuffer', 'unsentBuffer', style='filled', fillcolor='darksalmon')
    dot.node('sent', 'sent', style='filled', fillcolor='darksalmon')

    dot.node('Reply', 'Reply', style='filled', fillcolor='darksalmon')
    dot.node('Forward', 'Forward', style='filled', fillcolor='darksalmon')
    dot.node('GnusCompose', 'GnusCompose', style='filled', fillcolor='darksalmon')



    #####  Adding edges to define hierarchy
    #####
    # 1.1  -- 1.2 -- 1.3
    dot.edge('MTDT', 'SelectedCompositionFwrk', label='Abstraction')
    dot.edge('MTDT', 'MailingFile', label='Abstraction')
    dot.edge('MTDT', 'Interactive', label='Abstraction')
    dot.edge('MTDT', 'SendExtent', label='Abstraction')
    dot.edge('MTDT', 'OorR', label='Abstraction')
    dot.edge('MTDT', 'AddressBook', label='Abstraction')
    dot.edge('MTDT', 'Names', label='Abstraction')
    dot.edge('MTDT', 'Distributions', label='Abstraction')
    dot.edge('MTDT', 'Tracking', label='Abstraction')
    dot.edge('MTDT', 'CompositionModel', label='Abstraction')
    dot.edge('MTDT', 'ContentCustomization', label='Abstraction')


    dot.edge('SelectedCompositionFwrk', 'PlainText', label='Enum')
    dot.edge('SelectedCompositionFwrk', 'OrgMsg', label='Enum')
    dot.edge('SelectedCompositionFwrk', 'LaTeX', label='Enum')
    dot.edge('SelectedCompositionFwrk', 'Html', label='Enum')
    dot.edge('SelectedCompositionFwrk', 'WithSelMailing', label='Enum')

    dot.edge('CompositionModel', 'NativeComposition', label='Enum')
    dot.edge('CompositionModel', 'ExternalComposition', label='Enum')

    #
    dot.edge('MailingFile', 'TemplateFile')
    dot.edge('MailingFile', 'MailingCmnd')
    dot.edge('TemplateFile', 'MailingCmnd')
    dot.edge('MailingCmnd', 'SelectedMailing')

    dot.edge('SelectedMailing', 'MailingMenu')
    dot.edge('SelectedMailing', 'DistMenu')

    dot.edge('RecipientsList', 'MailingMenu')

    dot.edge('Interactive', 'Gnus')
    dot.edge('Interactive', 'MtdtMenu')
    dot.edge('MtdtMenu', 'DistMenu')
    dot.edge('MtdtMenu', 'MailingMenu')

    dot.edge('Gnus', 'Reply')
    dot.edge('Gnus', 'Forward')
    dot.edge('Gnus', 'GnusCompose')

    dot.edge('Reply', 'unsentBuffer')
    dot.edge('Forward', 'unsentBuffer')
    dot.edge('GnusCompose', 'unsentBuffer')

    dot.edge('SelectedCompositionFwrk', 'Reply')
    dot.edge('SelectedCompositionFwrk', 'Forward')

    dot.edge('SendExtent', 'doSend')
    dot.edge('SendExtent', 'unsentBuf')

    dot.edge('OorR', 'Recipients')
    dot.edge('Recipients', 'RecipientsList')
    dot.edge('RecipientsList', 'RecipientsListForm')
    dot.edge('RecipientsListForm', 'RecipientsListFormFile')


    # dot.edge('AddressBook', 'bbdb2')
    dot.edge('AddressBook', 'bbdb3')

    dot.edge('Names', 'NamesFile')

    dot.edge('NamesFile', 'bbdb3')
    dot.edge('bbdb3', 'RecipientsListFormFile')

    dot.edge('RecipientsListFormFile', 'DistMenu')

    dot.edge('Distributions', 'DistNamesFile')

    dot.edge('DistNamesFile', 'RecipientsListFormFile')

    dot.edge('Tracking', 'LogFile')


    dot.edge('MailingMenu', 'sendWithExtent')
    dot.edge('DistMenu', 'sendWithExtent')

    dot.edge('sendWithExtent', 'unsentBuffer')
    dot.edge('sendWithExtent', 'sent')

    dot.edge('SendExtent', 'sendWithExtent')

    dot.edge('CompositionModel', 'sendWithExtent')
    dot.edge('ContentCustomization', 'sendWithExtent')


    return dot


####+BEGIN: b:py3:cs:func/typing :funcName "mtdtConceptsGraph_l0" :funcType "Typed" :deco "track"
""" #+begin_org
*  _[[elisp:(blee:menu-sel:outline:popupMenu)][±]]_ _[[elisp:(blee:menu-sel:navigation:popupMenu)][Ξ]]_ [[elisp:(outline-show-branches+toggle)][|=]] [[elisp:(bx:orgm:indirectBufOther)][|>]] *[[elisp:(blee:ppmm:org-mode-toggle)][|N]]*  F-T-Typed  [[elisp:(outline-show-subtree+toggle)][||]] /mtdtConceptsGraph_l0/  deco=track  [[elisp:(org-cycle)][| ]]
#+end_org """
@cs.track(fnLoc=True, fnEntry=True, fnExit=True)
def mtdtConceptsGraph_l0(
####+END:
) -> graphviz.Digraph:
    """ #+begin_org
** [[elisp:(org-cycle)][| *DocStr | ]
    #+end_org """

    dot = graphviz.Digraph(
        comment='Mailing File Creation',
        # graph_attr={'rankdir':'LR'},
    )

    #  LCNT
    dot.node('LCNT', 'LCNT:\nLibre\nContent', shape='circle', style='filled', fillcolor='darkseagreen3')
    dot.node('LcntMasFile', 'articleLtr.mastex\narticleRtl.mastex', shape='parallelogram', style='filled', fillcolor='khaki1')
    dot.node('LcntProcMailing', '\nlcntProc.sh\nMailing\n ',  shape='rarrow', style='filled', fillcolor='salmon3')

    #####
    dot.edge('LCNT', 'LcntMasFile', label='Specification')
    dot.edge('LCNT', 'LcntProcMailing', label='Usage')
    dot.edge('LcntMasFile', 'LcntProcMailing', label='Usage')


    # Layer 0
    dot.node('Start-Mailing', 'LAYER 1:\nCreate\nMailing\nFile', shape='circle', style='filled', fillcolor='darkseagreen3')

    # 1.1  1.2 1.3 - Redist Types

    # dot.node('StartMailingFile', 'Common Mailing\nFile', shape='parallelogram', style='filled', fillcolor='khaki1')

    dot.edge('LcntMasFile', 'MailingFile',  label='Content')
    dot.edge('LcntMasFile', 'TemplateFile',  label='Content')
    dot.edge('LcntMasFile', 'MuaStencil',  label='Content')
    dot.edge('LcntProcMailing', 'LcntMasFile',  dir='back', label='Processing')

    dot.edge('LcntProcMailing', 'MailingFileUsage', label='Usage')


    # Header

    #
    dot.node('PlainText', 'PlainText', shape='rect', style='filled', fillcolor='azure3')
    dot.node('OrgMsg', 'OrgMsg', shape='rect', style='filled', fillcolor='azure3')
    dot.node('LaTeX', 'LaTeX', shape='rect', style='filled', fillcolor='azure3')
    dot.node('Html', 'Html', shape='rect', style='filled', fillcolor='azure3')
    # dot.node('WithSelMailing', 'With\nSelected\nMailing', shape='rect', style='filled', fillcolor='azure3')


    #


    #####  Adding edges to define hierarchy
    #####
    dot.edge('Start-Mailing', 'MailingFile', label='Specification')
    dot.edge('Start-Mailing', 'TemplateFile', label='Specification')
    dot.edge('Start-Mailing', 'MuaStencil', label='Specification')

    dot.node('TemplateFile', 'Template\nFile',  shape='parallelogram', style='filled', fillcolor='khaki1')

    dot.node('MailingFile', 'Mailing\nFile',  shape='parallelogram', style='filled', fillcolor='khaki1')

    dot.node('MuaStencil', 'Mua\nStencil',  shape='parallelogram', style='filled', fillcolor='khaki1')

    dot.node('SelectedCompositionFwrk', 'X-ComposeFwrk', shape='cylinder', style='filled', fillcolor='green')

    dot.edge('SelectedCompositionFwrk', 'PlainText', dir='back', label='Enum')
    dot.edge('SelectedCompositionFwrk', 'OrgMsg',  dir='back', label='Enum')
    dot.edge('SelectedCompositionFwrk', 'LaTeX',  dir='back', label='Enum')
    dot.edge('SelectedCompositionFwrk', 'Html',  dir='back', label='Enum')
    # dot.edge('SelectedCompositionFwrk', 'WithSelMailing',  dir='back', label='Enum')

    dot.edge('MailingFile', 'SelectedCompositionFwrk', dir='back', label='Header')
    dot.edge('TemplateFile', 'SelectedCompositionFwrk', dir='back', label='Header')
    dot.edge('MuaStencil', 'SelectedCompositionFwrk', dir='back', label='Header')

    dot.node('Purpose', 'X-Mailing-Purpose', shape='cylinder', style='filled', fillcolor='green')

    dot.node('PurposeMailing', 'Mailing', shape='rect', style='filled', fillcolor='azure3')
    dot.node('PurposeTemplate', 'Template', shape='rect', style='filled', fillcolor='azure3')
    dot.node('PurposeMua', 'Mua', shape='rect', style='filled', fillcolor='azure3')
    # dot.node('PurposeAny', 'Any', shape='rect', style='filled', fillcolor='azure3')

    dot.edge('Purpose', 'PurposeMailing', dir='back', label='Enum')
    dot.edge('Purpose', 'PurposeTemplate',  dir='back', label='Enum')
    dot.edge('Purpose', 'PurposeMua',  dir='back', label='Enum')
    # dot.edge('Purpose', 'PurposeAny',  dir='back', label='Enum')

    dot.edge('MailingFile', 'Purpose', dir='back', label='Header')
    dot.edge('TemplateFile', 'Purpose', dir='back', label='Header')
    dot.edge('MuaStencil', 'Purpose', dir='back', label='Header')

    dot.node('SelectedCompositionModel', 'X-MailingParams\n:type ext\n(Composition Model)', shape='cylinder', style='filled', fillcolor='green')

    dot.node('ComposeNatModel', 'Native\nCompose\nModel\n', shape='rect', style='filled', fillcolor='azure3')
    dot.node('ComposeExtModel', 'External\nCompose\nModel\n', shape='rect', style='filled', fillcolor='azure3')

    dot.edge('SelectedCompositionModel', 'ComposeNatModel', dir='back', label='Enum')
    dot.edge('SelectedCompositionModel', 'ComposeExtModel', dir='back', label='Enum')

    dot.node('MailingName', 'X-MailingName', shape='cylinder', style='filled', fillcolor='green')

    dot.node('Customize', 'X-MTDT-Customize\n(file path)', shape='cylinder', style='filled', fillcolor='green')


    dot.edge('MailingFile', 'SelectedCompositionModel', dir='back', label='Header')
    dot.edge('TemplateFile', 'SelectedCompositionModel', dir='back', label='Header')
    dot.edge('MuaStencil', 'SelectedCompositionModel', dir='back', label='Header')

    dot.edge('MailingFile', 'MailingName', dir='back', label='Header')
    dot.edge('TemplateFile', 'MailingName', dir='back', label='Header')
    dot.edge('MuaStencil', 'MailingName', dir='back', label='Header')

    dot.edge('MailingFile', 'MailingName', dir='back', label='Header')
    dot.edge('TemplateFile', 'MailingName', dir='back', label='Header')
    dot.edge('MuaStencil', 'MailingName', dir='back', label='Header')

    dot.edge('MailingFile', 'Customize', dir='back', label='Header')
    dot.edge('TemplateFile', 'Customize', dir='back', label='Header')
    dot.edge('MuaStencil', 'Customize', dir='back', label='Header')

    # dot.node('MailingCmnd', 'Mailing\nCommand', shape='oval', style='filled', fillcolor='khaki1')

    dot.node('MailingFileUsage', '\nMailing\nFile\nUsage\n ',  shape='rarrow', style='filled', fillcolor='lightsalmon1')

    dot.edge('MailingFile', 'MailingFileUsage', label='Derive')
    dot.edge('TemplateFile', 'MailingFileUsage', label='Derive')
    dot.edge('MuaStencil', 'MailingFileUsage', label='Derive')

    return dot


####+BEGIN: b:py3:cs:func/typing :funcName "mtdtConceptsGraph_l1" :funcType "Typed" :deco "track"
""" #+begin_org
*  _[[elisp:(blee:menu-sel:outline:popupMenu)][±]]_ _[[elisp:(blee:menu-sel:navigation:popupMenu)][Ξ]]_ [[elisp:(outline-show-branches+toggle)][|=]] [[elisp:(bx:orgm:indirectBufOther)][|>]] *[[elisp:(blee:ppmm:org-mode-toggle)][|N]]*  F-T-Typed  [[elisp:(outline-show-subtree+toggle)][||]] /mtdtConceptsGraph_l1/  deco=track  [[elisp:(org-cycle)][| ]]
#+end_org """
@cs.track(fnLoc=True, fnEntry=True, fnExit=True)
def mtdtConceptsGraph_l1(
####+END:
) -> graphviz.Digraph:
    """ #+begin_org
** [[elisp:(org-cycle)][| *DocStr | ]
    #+end_org """

    dot = graphviz.Digraph(
        comment='MTDT-Mailing Concepts',
        # graph_attr={'rankdir':'LR'},
    )

    # 1- Gnu-Emacs
    dot.node('MTDT-Mailing', 'LAYER 1:\nMTDT\nMailing\nConcepts', shape='circle', style='filled', fillcolor='darkseagreen3')

    # 1.1  1.2 1.3 - Redist Types
    dot.node('SelectedCompositionFwrk', 'Selected\nCompositionn\nFramework', shape='cylinder', style='filled', fillcolor='green')
    dot.node('SelectedCompositionModel', 'Selected\nComposition\nModel', shape='cylinder', style='filled', fillcolor='green')
    dot.node('Interactive', 'Interactive\nUsage', shape='circle', style='filled', fillcolor='darksalmon')

    dot.node('X-MailingName', 'X-Mailing\nName', shape='parallelogram', style='filled', fillcolor='khaki1')

    dot.node('MailingFile', 'Mailing\nFile', shape='parallelogram', style='filled', fillcolor='khaki1')
    dot.node('CommencingFile', 'Commencing\nFile', shape='parallelogram', style='filled', fillcolor='khaki1')
    dot.node('TemplateFile', 'Template\nFile',  shape='parallelogram', style='filled', fillcolor='khaki1')
    dot.node('MuaStencil', 'Mua\nStencil',  shape='parallelogram', style='filled', fillcolor='khaki1')
    dot.node('CustomizeFile', 'Customize.el\nFile', shape='parallelogram', style='filled', fillcolor='khaki1')

    dot.node('PlainText', 'PlainText', shape='rect', style='filled', fillcolor='azure3')
    dot.node('OrgMsg', 'OrgMsg', shape='rect', style='filled', fillcolor='azure3')
    dot.node('LaTeX', 'LaTeX', shape='rect', style='filled', fillcolor='azure3')
    dot.node('Html', 'Html', shape='rect', style='filled', fillcolor='azure3')
    dot.node('WithSelMailing', 'With\nSelected\nMailing', shape='rect', style='filled', fillcolor='azure3')

    # dot.node('Purpose', 'Purpose', shape='cylinder', style='filled', fillcolor='green')

    # dot.node('PurposeMailing', 'Mailing', shape='rect', style='filled', fillcolor='azure3')
    # dot.node('PurposeTemplate', 'Template', shape='rect', style='filled', fillcolor='azure3')
    # dot.node('PurposeMua', 'Mua', shape='rect', style='filled', fillcolor='azure3')
    # dot.node('PurposeAny', 'Any', shape='rect', style='filled', fillcolor='azure3')

    dot.node('MailingCmnd', 'Mailing\nCommand', shape='oval', style='filled', fillcolor='khaki1')
    dot.node('ListOfMailingCmnds', 'List of\nMailing\nCommand',  shape='oval', style='filled', fillcolor='khaki1')
    dot.node('SelectedMailings', 'Selected\nList of\nMailings ', style='filled', fillcolor='green')
    dot.node('SelectedGnusMailing', 'Selected\nGnus\nMailing', style='filled', fillcolor='green')

    # 1.3.1  1.3.2
    dot.node('Gnus', '\nBlee\nGnus\n ', shape='rarrow', style='filled', fillcolor='orange')
    dot.node('Forward', '\nGnus\nForward\n ', shape='rarrow', style='filled', fillcolor='orange')
    dot.node('GnusCompose', '\nGnus\nCompose\n ', shape='rarrow', style='filled', fillcolor='orange')
    dot.node('Reply', '\nGnus\nReply\n ', shape='rarrow', style='filled', fillcolor='orange')

    dot.node('MtdtMailingMenu', '\nMTDT-Mailing\nMenu\n ', shape='rarrow', style='filled', fillcolor='salmon')

    dot.node('MailingOrgInitiator', '\nMailing\nOrg\nInitiator\n ',  shape='rarrow', style='filled', fillcolor='salmon2')
    dot.node('MailingOrgDblock', '\nMailing\nOrg\nDblocks\n ',  shape='rarrow', style='filled', fillcolor='salmon2')

    dot.node('lcntProcMailing', '\nlcntProc.sh\nMailing\n ',  shape='rarrow', style='filled', fillcolor='salmon3')

    dot.node('MailingFileUsage', '\nMailing\nFile\nUsage\n ',  shape='rarrow', style='filled', fillcolor='lightsalmon1')

    dot.node('MailingCompose', '\nMailing\nNative\nCompose\n ',  shape='rarrow', style='filled', fillcolor='magenta')
    dot.node('MailingExtCompose', '\nMailing\nExternal\nCompose\n ',  shape='rarrow', style='filled', fillcolor='magenta')

    dot.node('ComposeNatModel', 'Native\nCompose\nModel\n', shape='rect', style='filled', fillcolor='azure3')
    dot.node('ComposeExtModel', 'External\nCompose\nModel\n', shape='rect', style='filled', fillcolor='azure3')

    dot.node('unsentBuffer', 'Unsent\nMail\nBuffer',  shape='invtrapezium', style='filled', fillcolor='deepskyblue')

    dot.node('ResidentMTA', '\nResident\nMTA\n(MARMEE)\n ',  shape='cds', style='filled', fillcolor='cyan')

    dot.node('MailSnippets', '\nMail\nYasnippets',  shape='polygon', style='filled', fillcolor='gray83')


    #####  Adding edges to define hierarchy
    #####
    #####
    dot.edge('MTDT-Mailing', 'Interactive', label='Usage')
    dot.edge('MTDT-Mailing', 'SelectedCompositionFwrk', label='Configuration')
    dot.edge('MTDT-Mailing', 'SelectedCompositionModel', label='Configuration')
    dot.edge('MTDT-Mailing', 'X-MailingName', label='Specification')
    dot.edge('MTDT-Mailing', 'CustomizeFile', label='Specification')

    dot.edge('X-MailingName', 'CommencingFile', label='Specification')
    dot.edge('X-MailingName', 'MailingFile', label='Specification')
    dot.edge('X-MailingName', 'TemplateFile', label='Specification')
    dot.edge('X-MailingName', 'MuaStencil', label='Specification')

    dot.edge('SelectedCompositionFwrk', 'PlainText', dir='back', label='Enum')
    dot.edge('SelectedCompositionFwrk', 'OrgMsg',  dir='back', label='Enum')
    dot.edge('SelectedCompositionFwrk', 'LaTeX',  dir='back', label='Enum')
    dot.edge('SelectedCompositionFwrk', 'Html',  dir='back', label='Enum')
    dot.edge('SelectedCompositionFwrk', 'WithSelMailing',  dir='back', label='Enum')

    # dot.edge('MailingFile', 'Purpose', dir='back', label='Header')

    # dot.edge('Purpose', 'PurposeMailing', dir='back', label='Enum')
    # dot.edge('Purpose', 'PurposeTemplate',  dir='back', label='Enum')
    # dot.edge('Purpose', 'PurposeMua',  dir='back', label='Enum')
    # dot.edge('Purpose', 'PurposeAny',  dir='back', label='Enum')

    dot.edge('SelectedCompositionFwrk', 'Gnus', label='Inform')
    dot.edge('SelectedCompositionFwrk', 'MtdtMailingMenu', label='Inform')

    dot.edge('unsentBuffer', 'CustomizeFile', dir='back', label='Execute')
    dot.edge('MailingFile', 'MailingCmnd', label='Derive')
    dot.edge('TemplateFile', 'MailingCmnd', label='Derive')
    dot.edge('CommencingFile', 'MailingCmnd', label='Derive')
    dot.edge('MuaStencil', 'MailingCmnd', label='Derive')
    dot.edge('MailingCmnd', 'SelectedGnusMailing')
    dot.edge('MailingCmnd', 'ListOfMailingCmnds')
    dot.edge('ListOfMailingCmnds', 'SelectedMailings')

    dot.edge('SelectedMailings', 'MtdtMailingMenu', label='Inform')
    dot.edge('SelectedGnusMailing', 'Gnus', label='Inform')

    dot.edge('MtdtMailingMenu', 'MailingExtCompose')
    dot.edge('MtdtMailingMenu', 'MailingCompose')

    dot.edge('MailingExtCompose', 'unsentBuffer')
    dot.edge('MailingCompose', 'unsentBuffer')

    dot.edge('Interactive', 'Gnus')
    dot.edge('Interactive', 'MtdtMailingMenu')
    dot.edge('Interactive', 'MailingOrgInitiator')
    dot.edge('Interactive', 'lcntProcMailing')
    dot.edge('Interactive', 'MailingFileUsage')

    dot.edge('MailingOrgInitiator', 'MailingOrgDblock')

    dot.edge('MailingOrgDblock', 'MailingExtCompose')
    dot.edge('MailingOrgDblock', 'MailingCompose')
    dot.edge('MailingOrgDblock', 'SelectedMailings', dir='back', label='Select')

    dot.edge('lcntProcMailing', 'MailingExtCompose')
    dot.edge('lcntProcMailing', 'MailingCompose')
    dot.edge('lcntProcMailing', 'SelectedMailings', label='Select')

    dot.edge('MailingFileUsage', 'MailingExtCompose')
    dot.edge('MailingFileUsage', 'MailingCompose')
    dot.edge('MailingFileUsage', 'SelectedMailings', label='Select')

    dot.edge('Gnus', 'Reply')
    dot.edge('Gnus', 'Forward')
    dot.edge('Gnus', 'GnusCompose')

    dot.edge('Reply', 'unsentBuffer')
    dot.edge('Forward', 'unsentBuffer')
    dot.edge('GnusCompose', 'unsentBuffer')

    dot.edge('unsentBuffer', 'ResidentMTA', label='Inject')

    dot.edge('MailSnippets', 'unsentBuffer')

    dot.edge('SelectedCompositionModel', 'ComposeNatModel', dir='back', label='Enum')
    dot.edge('SelectedCompositionModel', 'ComposeExtModel', dir='back', label='Enum')

    dot.edge('SelectedCompositionModel', 'Gnus')

    return dot


####+BEGIN: b:py3:cs:func/typing :funcName "mtdtConceptsGraph_l2" :funcType "Typed" :deco "track"
""" #+begin_org
*  _[[elisp:(blee:menu-sel:outline:popupMenu)][±]]_ _[[elisp:(blee:menu-sel:navigation:popupMenu)][Ξ]]_ [[elisp:(outline-show-branches+toggle)][|=]] [[elisp:(bx:orgm:indirectBufOther)][|>]] *[[elisp:(blee:ppmm:org-mode-toggle)][|N]]*  F-T-Typed  [[elisp:(outline-show-subtree+toggle)][||]] /mtdtConceptsGraph_l2/  deco=track  [[elisp:(org-cycle)][| ]]
#+end_org """
@cs.track(fnLoc=True, fnEntry=True, fnExit=True)
def mtdtConceptsGraph_l2(
####+END:
) -> graphviz.Digraph:
    """ #+begin_org
** [[elisp:(org-cycle)][| *DocStr | ]
    #+end_org """

    dot = graphviz.Digraph(
        comment='MTDT-Distribution Concepts',
        # graph_attr={'rankdir':'LR'},
    )

    #  LAYER-1  Summary
    dot.node('MTDT-Mailing', 'MTDT\nMailing\nConcepts\nLAYER 1', shape='circle', style='filled', fillcolor='darkseagreen3')
    dot.node('MailingFile', 'Mailing\nFile', shape='parallelogram', style='filled', fillcolor='khaki1')
    dot.node('TemplateFile', 'Template\nFile',  shape='parallelogram', style='filled', fillcolor='khaki1')
    dot.node('MailingCmnd', 'Mailing\nCommand', shape='oval', style='filled', fillcolor='khaki1')
    dot.node('ListOfMailingCmnds', 'List of\nMailing\nCommand',  shape='oval', style='filled', fillcolor='khaki1')
    dot.node('SelectedMailings', 'Selected\nList of\nMailings ', style='filled', fillcolor='green')

    # LAYER-2  FULL
    #
    dot.node('MTDT-Distribution', 'MTDT\nDistribution\nConcepts\nLAYER 2', shape='circle', style='filled', fillcolor='darkseagreen3')

    dot.node('Interactive', 'Interactive\nUsage', shape='circle', style='filled', fillcolor='darksalmon')
    dot.node('SendExtent', 'Selected\nSend\nExtent', shape='cylinder', style='filled', fillcolor='darksalmon')
    dot.node('OorR', 'Orig Or Recipients', shape='cylinder', style='filled', fillcolor='khaki1')
    dot.node('AddressBook', 'Address Book', shape='cylinder', style='filled', fillcolor='khaki1')
    dot.node('Names', 'Names', shape='cylinder', style='filled', fillcolor='khaki1')
    dot.node('Distributions', 'Distributions', shape='cylinder', style='filled', fillcolor='khaki1')
    dot.node('Tracking', 'Tracking', shape='cylinder', style='filled', fillcolor='khaki1')

    #dot.node('MtdtMenu', 'MTDT Menu', style='filled', fillcolor='green')
    dot.node('MtdtMenu', '\nMTDT-Distribution\nMenu\n ', shape='rarrow', style='filled', fillcolor='salmon')
    #dot.node('DistMenu', 'Distribution Menu', style='filled', fillcolor='green')

    dot.node('lcntProcMailing', '\nlcntProc.sh\nMailing\n ',  shape='rarrow', style='filled', fillcolor='salmon3')

    # 1.2.1.1
    dot.node('SendExtent', 'Selected\nSend\nExtent', style='filled', fillcolor='green')
    dot.node('doSend', 'doSend',  shape='rect', style='filled', fillcolor='azure3')
    dot.node('unsentBuf', 'unsentBuffer',  shape='rect', style='filled', fillcolor='azure3')

    # 1.3.1.1  1.3.2.1
    dot.node('Recipients', 'Recipients', style='filled', fillcolor='khaki1')
    dot.node('RecipientsList', 'Recipients List', style='filled', fillcolor='khaki1')
    dot.node('RecipientsListForm', 'Recipients List Form',  style='filled', fillcolor='khaki1')
    dot.node('RecipientsListFormFile', 'Selected\nRecipients\nList\nForm\n File',  style='filled', fillcolor='green')

    dot.node('bbdb2', 'bbdb2', style='filled', fillcolor='khaki1')
    dot.node('bbdb3', 'bbdb3', style='filled', fillcolor='khaki1')

    dot.node('NamesFile', 'namesFile', style='filled', fillcolor='khaki1')

    dot.node('DistNamesFile', 'distNamesFile', style='filled', fillcolor='khaki1')

    dot.node('LogFile', 'logFile', style='filled', fillcolor='khaki1')

    dot.node('sendWithExtent', 'sendWithExtent', style='filled', fillcolor='darksalmon')
    dot.node('unsentBuffer', 'Unsent\nMail\nBuffer',  shape='invtrapezium', style='filled', fillcolor='deepskyblue')
    dot.node('sent', '\nResident\nMTA\n(MARMEE)\n ',  shape='cds', style='filled', fillcolor='cyan')

    #####  Adding edges to define hierarchy
    #####
    # 1.1  -- 1.2 -- 1.3
    dot.edge('MTDT-Mailing', 'MailingFile', label='Specification')

    #
    dot.edge('MailingFile', 'TemplateFile')
    dot.edge('MailingFile', 'MailingCmnd', label='Derive')
    dot.edge('TemplateFile', 'MailingCmnd', label='Derive')
    dot.edge('MailingCmnd', 'ListOfMailingCmnds')
    dot.edge('ListOfMailingCmnds', 'SelectedMailings')

    #####  Adding edges to define hierarchy
    #####
    # 1.1  -- 1.2 -- 1.3
    dot.edge('MTDT-Distribution', 'Interactive', label='Execution')
    dot.edge('MTDT-Distribution', 'SendExtent', label='Configuration')
    dot.edge('MTDT-Distribution', 'OorR', label='Machinary')
    dot.edge('MTDT-Distribution', 'AddressBook', label='Specification')
    dot.edge('MTDT-Distribution', 'Names', label='Specification')
    dot.edge('MTDT-Distribution', 'Distributions', label='Specification')
    dot.edge('MTDT-Distribution', 'Tracking', label='Machinary')

    #

    # dot.edge('SelectedMailings', 'MailingMenu')
    dot.edge('SelectedMailings', 'MtdtMenu')

    # dot.edge('RecipientsList', 'MailingMenu')

    dot.edge('Interactive', 'MtdtMenu')
    dot.edge('Interactive', 'lcntProcMailing')
    # dot.edge('MtdtMenu', 'DistMenu')

    # dot.edge('MailingMenu', 'sendWithExtent')
    dot.edge('MtdtMenu', 'sendWithExtent')
    dot.edge('lcntProcMailing', 'sendWithExtent')

    dot.edge('sendWithExtent', 'unsentBuffer')
    dot.edge('sendWithExtent', 'sent')
    dot.edge('unsentBuffer', 'sent')


    dot.edge('SendExtent', 'doSend', dir='back', label='Enum')
    dot.edge('SendExtent', 'unsentBuf', dir='back', label='Enum')
    dot.edge('SendExtent', 'sendWithExtent', label='inform')


    dot.edge('OorR', 'Recipients')
    dot.edge('Recipients', 'RecipientsList')
    dot.edge('RecipientsList', 'RecipientsListForm')
    dot.edge('RecipientsListForm', 'RecipientsListFormFile')

    dot.edge('AddressBook', 'bbdb2')
    dot.edge('AddressBook', 'bbdb3')

    dot.edge('Names', 'NamesFile')
    dot.edge('NamesFile', 'bbdb2')
    dot.edge('bbdb2', 'RecipientsListFormFile')
    dot.edge('NamesFile', 'bbdb3')
    dot.edge('bbdb3', 'RecipientsListFormFile')

    dot.edge('RecipientsListFormFile', 'MtdtMenu')

    dot.edge('Distributions', 'DistNamesFile')

    dot.edge('DistNamesFile', 'RecipientsListFormFile')

    dot.edge('Tracking', 'LogFile')
    dot.edge('LogFile', 'Distributions')

    return dot


####+BEGIN: b:py3:cs:func/typing :funcName "mtdtConceptsGraph_l3" :funcType "Typed" :deco "track"
""" #+begin_org
*  _[[elisp:(blee:menu-sel:outline:popupMenu)][±]]_ _[[elisp:(blee:menu-sel:navigation:popupMenu)][Ξ]]_ [[elisp:(outline-show-branches+toggle)][|=]] [[elisp:(bx:orgm:indirectBufOther)][|>]] *[[elisp:(blee:ppmm:org-mode-toggle)][|N]]*  F-T-Typed  [[elisp:(outline-show-subtree+toggle)][||]] /mtdtConceptsGraph_l3/  deco=track  [[elisp:(org-cycle)][| ]]
#+end_org """
@cs.track(fnLoc=True, fnEntry=True, fnExit=True)
def mtdtConceptsGraph_l3(
####+END:
) -> graphviz.Digraph:
    """ #+begin_org
** [[elisp:(org-cycle)][| *DocStr | ]
    #+end_org """

    dot = graphviz.Digraph(
        comment='MTDT-Distribution Concepts',
        # graph_attr={'rankdir':'LR'},
    )

    #  LAYER-1  Summary
    dot.node('MTDT-Mailing', 'MTDT\nMailing\nConcepts\nLAYER 1', shape='circle', style='filled', fillcolor='darkseagreen3')
    dot.node('MailingFile', 'Mailing\nFile', shape='parallelogram', style='filled', fillcolor='khaki1')
    dot.node('TemplateFile', 'Template\nFile',  shape='parallelogram', style='filled', fillcolor='khaki1')
    dot.node('MailingCmnd', 'Mailing\nCommand', shape='oval', style='filled', fillcolor='khaki1')
    dot.node('ListOfMailingCmnds', 'List of\nMailing\nCommand',  shape='oval', style='filled', fillcolor='khaki1')
    dot.node('SelectedMailings', 'Selected\nList of\nMailings ', style='filled', fillcolor='green')


    # LAYER-2  Summary
    #
    dot.node('MTDT-Distribution', 'MTDT\nDistribution\nConcepts\nLAYER 2', shape='circle', style='filled', fillcolor='darkseagreen3')

    dot.node('OorR', 'Orig Or Recipients', shape='cylinder', style='filled', fillcolor='khaki1')

    dot.node('SendExtent', 'Selected\nSend\nExtent', style='filled', fillcolor='green')
    dot.node('doSend', 'doSend',  shape='rect', style='filled', fillcolor='azure3')
    dot.node('unsentBuf', 'unsentBuffer',  shape='rect', style='filled', fillcolor='azure3')

    # 1.3.1.1  1.3.2.1
    dot.node('Recipients', 'Recipients', style='filled', fillcolor='khaki1')
    dot.node('RecipientsList', 'Recipients List', style='filled', fillcolor='khaki1')
    dot.node('RecipientsListForm', 'Recipients List Form',  style='filled', fillcolor='khaki1')
    dot.node('RecipientsListFormFile', 'Selected\nRecipients\nList\nForm\n File',  style='filled', fillcolor='green')

    dot.node('sendWithExtent', 'sendWithExtent', style='filled', fillcolor='darksalmon')
    dot.node('unsentBuffer', 'Unsent\nMail\nBuffer',  shape='invtrapezium', style='filled', fillcolor='deepskyblue')
    dot.node('sent', '\nResident\nMTA\n(MARMEE)\n ',  shape='cds', style='filled', fillcolor='cyan')

    #####  Adding edges to define hierarchy
    #####
    # 1.1  -- 1.2 -- 1.3
    dot.edge('MTDT-Mailing', 'MailingFile', label='Specification')

    #
    dot.edge('MailingFile', 'TemplateFile')
    dot.edge('MailingFile', 'MailingCmnd', label='Derive')
    dot.edge('TemplateFile', 'MailingCmnd', label='Derive')
    dot.edge('MailingCmnd', 'ListOfMailingCmnds')
    dot.edge('ListOfMailingCmnds', 'SelectedMailings')

    #####  Adding edges to define hierarchy
    #####
    # 1.1  -- 1.2 -- 1.3
    dot.edge('MTDT-Distribution', 'SendExtent', label='Configuration')
    dot.edge('MTDT-Distribution', 'OorR', label='Machinary')


    dot.edge('sendWithExtent', 'unsentBuffer')
    dot.edge('sendWithExtent', 'sent')
    dot.edge('unsentBuffer', 'sent')

    dot.edge('SendExtent', 'doSend', dir='back', label='Enum')
    dot.edge('SendExtent', 'unsentBuf', dir='back', label='Enum')
    dot.edge('SendExtent', 'sendWithExtent', label='inform')

    dot.edge('OorR', 'Recipients')
    dot.edge('Recipients', 'RecipientsList')
    dot.edge('RecipientsList', 'RecipientsListForm')
    dot.edge('RecipientsListForm', 'RecipientsListFormFile')


    # LAYER-3  FULL
    #
    dot.node('MTDT-Share', 'MTDT\nShare\nConcepts\nLAYER 3', shape='circle', style='filled', fillcolor='darkseagreen3')
    dot.node('Interactive', 'Interactive\nUsage', shape='circle', style='filled', fillcolor='darksalmon')

    dot.node('BrowserShare', '\nBrowser\nShare\n ', shape='rarrow', style='filled', fillcolor='salmon')
    dot.node('DiredShare', '\nDired\nShare\n ',  shape='rarrow', style='filled', fillcolor='salmon3')

    #####  Adding edges to define hierarchy

    dot.edge('MTDT-Share', 'Interactive', label='Execution')

    dot.edge('SelectedMailings', 'BrowserShare')
    dot.edge('SelectedMailings', 'DiredShare')

    dot.edge('RecipientsListFormFile', 'BrowserShare')
    dot.edge('RecipientsListFormFile', 'DiredShare')

    dot.edge('Interactive', 'BrowserShare')
    dot.edge('Interactive', 'DiredShare')

    dot.edge('BrowserShare', 'sendWithExtent')
    dot.edge('DiredShare', 'sendWithExtent')

    return dot

def mtdtConceptsGraphClustered() -> graphviz.Digraph:
    dot = graphviz.Digraph(
        comment='MTDT Concepts (Clustered)',
        graph_attr={'rankdir': 'LR'},
    )

    # Central node
    dot.node('MTDT', 'MTDT\nConcepts', shape='circle', style='filled', fillcolor='darkseagreen3')

    # Cluster: Composition Framework
    with dot.subgraph(name='cluster_composition') as c:
        c.attr(label='Composition Framework', style='filled', color='lightgrey')
        c.node('SelectedCompositionFwrk', 'Selected Composition Framework', shape='cylinder', style='filled', fillcolor='green')
        for node in ['PlainText', 'OrgMsg', 'LaTeX', 'Html', 'WithSelMailing']:
            c.node(node, node, style='filled', fillcolor='green')
            c.edge('SelectedCompositionFwrk', node, label='Enum')
        c.edge('MTDT', 'SelectedCompositionFwrk', label='Abstraction')

    # Cluster: Composition Models
    with dot.subgraph(name='cluster_models') as c:
        c.attr(label='Composition Models', style='filled', color='lightgrey')
        c.node('CompositionModel', 'Composition Model', style='filled', fillcolor='green')
        c.node('NativeComposition', 'Native Composition', style='filled', fillcolor='green')
        c.node('ExternalComposition', 'External Composition', style='filled', fillcolor='green')
        c.edge('CompositionModel', 'NativeComposition', label='Enum')
        c.edge('CompositionModel', 'ExternalComposition', label='Enum')
        c.edge('MTDT', 'CompositionModel', label='Abstraction')

    # Cluster: Mailing Configuration
    with dot.subgraph(name='cluster_mailing') as c:
        c.attr(label='Mailing Configuration', style='filled', color='lightgrey')
        for node in ['MailingFile', 'TemplateFile', 'MailingCmnd', 'SelectedMailing', 'MailingMenu', 'DistMenu']:
            fill = 'green' if node in ['TemplateFile', 'MailingCmnd', 'SelectedMailing', 'MailingMenu', 'DistMenu'] else 'darksalmon'
            c.node(node, node, shape='cylinder' if 'File' in node else '', style='filled', fillcolor=fill)
        c.edges([('MailingFile', 'TemplateFile'), ('MailingFile', 'MailingCmnd'),
                 ('TemplateFile', 'MailingCmnd'), ('MailingCmnd', 'SelectedMailing'),
                 ('SelectedMailing', 'MailingMenu'), ('SelectedMailing', 'DistMenu')])
        c.edge('MTDT', 'MailingFile', label='Abstraction')

    # Cluster: Interactive
    with dot.subgraph(name='cluster_interactive') as c:
        c.attr(label='Interactive Usage', style='filled', color='lightgrey')
        for node in ['Interactive', 'Gnus', 'Reply', 'Forward', 'GnusCompose', 'MtdtMenu']:
            c.node(node, node, style='filled', fillcolor='green')
        c.edges([('Interactive', 'Gnus'), ('Gnus', 'Reply'), ('Gnus', 'Forward'), ('Gnus', 'GnusCompose'),
                 ('Interactive', 'MtdtMenu'), ('MtdtMenu', 'DistMenu'), ('MtdtMenu', 'MailingMenu')])
        c.edge('MTDT', 'Interactive', label='Abstraction')

    # Cluster: Recipient Management
    with dot.subgraph(name='cluster_recipients') as c:
        c.attr(label='Recipient Management', style='filled', color='lightgrey')
        nodes = ['OorR', 'Recipients', 'RecipientsList', 'RecipientsListForm',
                 'RecipientsListFormFile', 'bbdb3', 'Names', 'NamesFile']
        for node in nodes:
            c.node(node, node, style='filled', fillcolor='darksalmon')
        c.edge('MTDT', 'OorR', label='Abstraction')
        c.edges([('OorR', 'Recipients'), ('Recipients', 'RecipientsList'),
                 ('RecipientsList', 'RecipientsListForm'), ('RecipientsListForm', 'RecipientsListFormFile'),
                 ('Names', 'NamesFile'), ('NamesFile', 'bbdb3'), ('bbdb3', 'RecipientsListFormFile')])

    # Cluster: Distributions and Tracking
    with dot.subgraph(name='cluster_distributions') as c:
        c.attr(label='Distributions & Tracking', style='filled', color='lightgrey')
        c.node('Distributions', 'Distributions', style='filled', fillcolor='darksalmon')
        c.node('DistNamesFile', 'distNamesFile', style='filled', fillcolor='darksalmon')
        c.node('Tracking', 'Tracking', style='filled', fillcolor='darksalmon')
        c.node('LogFile', 'logFile', style='filled', fillcolor='darksalmon')
        c.edges([('Distributions', 'DistNamesFile'), ('DistNamesFile', 'RecipientsListFormFile'),
                 ('Tracking', 'LogFile')])
        c.edge('MTDT', 'Distributions', label='Abstraction')
        c.edge('MTDT', 'Tracking', label='Abstraction')

    # Cluster: Dispatch
    with dot.subgraph(name='cluster_dispatch') as c:
        c.attr(label='Dispatch', style='filled', color='lightgrey')
        for node in ['SendExtent', 'sendWithExtent', 'unsentBuffer', 'sent', 'doSend', 'unsentBuf', 'ContentCustomization']:
            fill = 'green' if node in ['SendExtent', 'sendWithExtent', 'doSend', 'unsentBuf', 'ContentCustomization'] else 'darksalmon'
            c.node(node, node, style='filled', fillcolor=fill)
        c.edges([('SendExtent', 'doSend'), ('SendExtent', 'unsentBuf'),
                 ('MailingMenu', 'sendWithExtent'), ('DistMenu', 'sendWithExtent'),
                 ('sendWithExtent', 'unsentBuffer'), ('sendWithExtent', 'sent'),
                 ('SendExtent', 'sendWithExtent'), ('CompositionModel', 'sendWithExtent'),
                 ('ContentCustomization', 'sendWithExtent')])
        c.edge('MTDT', 'SendExtent', label='Abstraction')
        c.edge('MTDT', 'ContentCustomization', label='Abstraction')

    return dot


import graphviz

def clustered_mtdtConceptsGraph_l0():
    dot = graphviz.Digraph(comment='Clustered Mailing File Creation')

    # Cluster: LCNT
    with dot.subgraph(name='cluster_lcnt') as c:
        c.attr(label='LCNT System', style='filled', color='lightgrey')
        c.node('LCNT', 'LCNT:\nLibre\nContent', shape='circle', style='filled', fillcolor='darkseagreen3')
        c.node('LcntMasFile', 'articleLtr.mastex\narticleRtl.mastex', shape='parallelogram', style='filled', fillcolor='khaki1')
        c.node('LcntProcMailing', '\nlcntProc.sh\nMailing\n', shape='rarrow', style='filled', fillcolor='salmon3')
        c.edge('LCNT', 'LcntMasFile', label='Specification')
        c.edge('LCNT', 'LcntProcMailing', label='Usage')
        c.edge('LcntMasFile', 'LcntProcMailing', label='Usage')
        c.edge('LcntProcMailing', 'LcntMasFile', dir='back', label='Processing')

    # Cluster: Mailing File Gen
    with dot.subgraph(name='cluster_mailing') as c:
        c.attr(label='Mailing File Generation', style='filled', color='lightyellow')
        c.node('Start-Mailing', 'LAYER 1:\nCreate\nMailing\nFile', shape='circle', style='filled', fillcolor='darkseagreen3')
        c.node('MailingFile', 'Mailing\nFile', shape='parallelogram', style='filled', fillcolor='khaki1')
        c.node('TemplateFile', 'Template\nFile', shape='parallelogram', style='filled', fillcolor='khaki1')
        c.node('MuaStencil', 'Mua\nStencil', shape='parallelogram', style='filled', fillcolor='khaki1')
        c.edge('LcntMasFile', 'MailingFile', label='Content')
        c.edge('LcntMasFile', 'TemplateFile', label='Content')
        c.edge('LcntMasFile', 'MuaStencil', label='Content')
        c.edge('Start-Mailing', 'MailingFile', label='Specification')
        c.edge('Start-Mailing', 'TemplateFile', label='Specification')
        c.edge('Start-Mailing', 'MuaStencil', label='Specification')

    # Cluster: Header Metadata
    with dot.subgraph(name='cluster_headers') as c:
        c.attr(label='Mailing Header Metadata', style='filled', color='azure')
        c.node('SelectedCompositionFwrk', 'X-ComposeFwrk', shape='cylinder', style='filled', fillcolor='green')
        c.node('PlainText', 'PlainText', shape='rect', style='filled', fillcolor='azure3')
        c.node('OrgMsg', 'OrgMsg', shape='rect', style='filled', fillcolor='azure3')
        c.node('LaTeX', 'LaTeX', shape='rect', style='filled', fillcolor='azure3')
        c.node('Html', 'Html', shape='rect', style='filled', fillcolor='azure3')
        c.edge('SelectedCompositionFwrk', 'PlainText', dir='back', label='Enum')
        c.edge('SelectedCompositionFwrk', 'OrgMsg', dir='back', label='Enum')
        c.edge('SelectedCompositionFwrk', 'LaTeX', dir='back', label='Enum')
        c.edge('SelectedCompositionFwrk', 'Html', dir='back', label='Enum')
        c.edge('MailingFile', 'SelectedCompositionFwrk', dir='back', label='Header')
        c.edge('TemplateFile', 'SelectedCompositionFwrk', dir='back', label='Header')
        c.edge('MuaStencil', 'SelectedCompositionFwrk', dir='back', label='Header')

    # Other Header Clusters
    for concept, items in {
        'Purpose': ['Mailing', 'Template', 'Mua'],
        'SelectedCompositionModel': ['ComposeNatModel', 'ComposeExtModel'],
    }.items():
        with dot.subgraph(name=f'cluster_{concept.lower()}') as c:
            c.attr(label=concept, style='filled', color='lightcyan')
            c.node(concept, f'X-{concept}', shape='cylinder', style='filled', fillcolor='green')
            for item in items:
                c.node(item, item.replace('Compose', '').replace('Model', '').strip(), shape='rect', style='filled', fillcolor='azure3')
                c.edge(concept, item, dir='back', label='Enum')
            dot.edge('MailingFile', concept, dir='back', label='Header')
            dot.edge('TemplateFile', concept, dir='back', label='Header')
            dot.edge('MuaStencil', concept, dir='back', label='Header')

    # Mailing Name and Customization
    dot.node('MailingName', 'X-MailingName', shape='cylinder', style='filled', fillcolor='green')
    dot.node('Customize', 'X-MTDT-Customize\n(file path)', shape='cylinder', style='filled', fillcolor='green')
    for header in ['MailingName', 'Customize']:
        for source in ['MailingFile', 'TemplateFile', 'MuaStencil']:
            dot.edge(source, header, dir='back', label='Header')

    # Mailing Usage
    dot.node('MailingFileUsage', '\nMailing\nFile\nUsage\n', shape='rarrow', style='filled', fillcolor='lightsalmon1')
    dot.edge('MailingFile', 'MailingFileUsage', label='Derive')
    dot.edge('TemplateFile', 'MailingFileUsage', label='Derive')
    dot.edge('MuaStencil', 'MailingFileUsage', label='Derive')
    dot.edge('LcntProcMailing', 'MailingFileUsage', label='Usage')

    return dot


def clustered_mtdtConceptsGraph_l1() -> graphviz.Digraph:
    """ #+begin_org
** [[elisp:(org-cycle)][| *DocStr | ]
    #+end_org """

    dot = graphviz.Digraph(
        comment='MTDT-Distribution Concepts',
    )

    # -------------------------------
    # Global Style Shortcuts
    # -------------------------------
    def add_node(name, label, shape='ellipse', color='khaki1', **kwargs):
        dot.node(name, label, shape=shape, style='filled', fillcolor=color, **kwargs)

    def add_edge(src, dst, label='', **kwargs):
        dot.edge(src, dst, label=label, **kwargs)

    # -------------------------------
    # Layer 1: Mailing Summary
    # -------------------------------
    with dot.subgraph(name='cluster_layer1') as l1:
        l1.attr(label='Layer 1: Mailing Concepts', style='dashed')

        add_node('MTDT-Mailing', 'MTDT\nMailing\nConcepts\nLAYER 1', shape='circle', color='darkseagreen3')
        add_node('MailingFile', 'Mailing\nFile', shape='parallelogram')
        add_node('TemplateFile', 'Template\nFile', shape='parallelogram')
        add_node('MailingCmnd', 'Mailing\nCommand')
        add_node('ListOfMailingCmnds', 'List of\nMailing\nCommands')
        add_node('SelectedMailings', 'Selected\nMailings', color='green')

        # Layer 1 Edges
        add_edge('MTDT-Mailing', 'MailingFile', label='Specification')
        add_edge('MailingFile', 'TemplateFile')
        add_edge('MailingFile', 'MailingCmnd', label='Derive')
        add_edge('TemplateFile', 'MailingCmnd', label='Derive')
        add_edge('MailingCmnd', 'ListOfMailingCmnds')
        add_edge('ListOfMailingCmnds', 'SelectedMailings')

    # -------------------------------
    # Layer 2: Distribution Concepts
    # -------------------------------
    with dot.subgraph(name='cluster_layer2') as l2:
        l2.attr(label='Layer 2: Distribution Concepts', style='dashed')

        add_node('MTDT-Distribution', 'MTDT\nDistribution\nConcepts\nLAYER 2', shape='circle', color='darkseagreen3')

        # Core Process Nodes
        add_node('Interactive', 'Interactive\nUsage', shape='circle', color='darksalmon')
        add_node('SendExtent', 'Selected\nSend\nExtent', shape='cylinder', color='green')
        add_node('OorR', 'Orig or\nRecipients', shape='cylinder')
        add_node('AddressBook', 'Address\nBook', shape='cylinder')
        add_node('Names', 'Names', shape='cylinder')
        add_node('Distributions', 'Distributions', shape='cylinder')
        add_node('Tracking', 'Tracking', shape='cylinder')
        add_node('MtdtMenu', 'MTDT\nMenu', shape='rarrow', color='salmon')
        add_node('lcntProcMailing', 'lcntProc.sh\nMailing', shape='rarrow', color='salmon3')

        # Edges: Core Process
        add_edge('MTDT-Distribution', 'Interactive', label='Execution')
        add_edge('MTDT-Distribution', 'SendExtent', label='Configuration')
        add_edge('MTDT-Distribution', 'OorR', label='Machinery')
        add_edge('MTDT-Distribution', 'AddressBook', label='Specification')
        add_edge('MTDT-Distribution', 'Names', label='Specification')
        add_edge('MTDT-Distribution', 'Distributions', label='Specification')
        add_edge('MTDT-Distribution', 'Tracking', label='Machinery')

        add_edge('SelectedMailings', 'MtdtMenu')
        add_edge('Interactive', 'MtdtMenu')
        add_edge('Interactive', 'lcntProcMailing')
        add_edge('MtdtMenu', 'sendWithExtent')
        add_edge('lcntProcMailing', 'sendWithExtent')

        # Process Chain
        add_node('sendWithExtent', 'sendWithExtent', color='darksalmon')
        add_node('unsentBuffer', 'Unsent\nMail\nBuffer', shape='invtrapezium', color='deepskyblue')
        add_node('sent', 'Resident\nMTA\n(MARMEE)', shape='cds', color='cyan')
        add_edge('sendWithExtent', 'unsentBuffer')
        add_edge('sendWithExtent', 'sent')
        add_edge('unsentBuffer', 'sent')

    # -------------------------------
    # Subcomponents: Recipients & Address Book
    # -------------------------------
    add_node('doSend', 'doSend', shape='rect', color='azure3')
    add_node('unsentBuf', 'unsentBuffer', shape='rect', color='azure3')
    add_edge('SendExtent', 'doSend', dir='back', label='Enum')
    add_edge('SendExtent', 'unsentBuf', dir='back', label='Enum')
    add_edge('SendExtent', 'sendWithExtent', label='inform')

    # Recipients Chain
    add_node('Recipients', 'Recipients')
    add_node('RecipientsList', 'Recipients List')
    add_node('RecipientsListForm', 'Recipients List\nForm')
    add_node('RecipientsListFormFile', 'Selected\nRecipients\nForm File', color='green')

    add_edge('OorR', 'Recipients')
    add_edge('Recipients', 'RecipientsList')
    add_edge('RecipientsList', 'RecipientsListForm')
    add_edge('RecipientsListForm', 'RecipientsListFormFile')
    add_edge('RecipientsListFormFile', 'MtdtMenu')

    # Address Book
    add_node('bbdb2', 'bbdb2')
    add_node('bbdb3', 'bbdb3')
    add_edge('AddressBook', 'bbdb2')
    add_edge('AddressBook', 'bbdb3')

    # Names
    add_node('NamesFile', 'namesFile')
    add_edge('Names', 'NamesFile')
    add_edge('NamesFile', 'bbdb2')
    add_edge('NamesFile', 'bbdb3')
    add_edge('bbdb2', 'RecipientsListFormFile')
    add_edge('bbdb3', 'RecipientsListFormFile')

    # Distributions
    add_node('DistNamesFile', 'distNamesFile')
    add_edge('Distributions', 'DistNamesFile')
    add_edge('DistNamesFile', 'RecipientsListFormFile')

    # Tracking
    add_node('LogFile', 'logFile')
    add_edge('Tracking', 'LogFile')
    add_edge('LogFile', 'Distributions')

    return dot

def clustered_mtdtConceptsGraph_l2() -> graphviz.Digraph:
    """ #+begin_org
** [[elisp:(org-cycle)][| *DocStr | ]
    #+end_org """

    dot = graphviz.Digraph(
        comment='MTDT-Distribution Concepts',
    )

    # === Cluster: Layer 1 - Mailing Concepts ===
    with dot.subgraph(name='cluster_L1_Mailing') as c:
        c.attr(label='LAYER 1: Mailing Concepts', style='filled', color='lightgrey')
        c.node('MTDT-Mailing', 'MTDT\nMailing\nConcepts\nLAYER 1', shape='circle', style='filled', fillcolor='darkseagreen3')
        c.node('MailingFile', 'Mailing\nFile', shape='parallelogram', style='filled', fillcolor='khaki1')
        c.node('TemplateFile', 'Template\nFile', shape='parallelogram', style='filled', fillcolor='khaki1')
        c.node('MailingCmnd', 'Mailing\nCommand', shape='oval', style='filled', fillcolor='khaki1')
        c.node('ListOfMailingCmnds', 'List of\nMailing\nCommand', shape='oval', style='filled', fillcolor='khaki1')
        c.node('SelectedMailings', 'Selected\nList of\nMailings', style='filled', fillcolor='green')

    # === Cluster: Layer 2 - Distribution Concepts ===
    with dot.subgraph(name='cluster_L2_Distribution') as c:
        c.attr(label='LAYER 2: Distribution Concepts', style='filled', color='lightgrey')
        c.node('MTDT-Distribution', 'MTDT\nDistribution\nConcepts\nLAYER 2', shape='circle', style='filled', fillcolor='darkseagreen3')
        c.node('Interactive', 'Interactive\nUsage', shape='circle', style='filled', fillcolor='darksalmon')
        c.node('SendExtent', 'Selected\nSend\nExtent', shape='cylinder', style='filled', fillcolor='darksalmon')
        c.node('OorR', 'Orig Or Recipients', shape='cylinder', style='filled', fillcolor='khaki1')
        c.node('AddressBook', 'Address Book', shape='cylinder', style='filled', fillcolor='khaki1')
        c.node('Names', 'Names', shape='cylinder', style='filled', fillcolor='khaki1')
        c.node('Distributions', 'Distributions', shape='cylinder', style='filled', fillcolor='khaki1')
        c.node('Tracking', 'Tracking', shape='cylinder', style='filled', fillcolor='khaki1')

    # === Cluster: Menu and Commands ===
    with dot.subgraph(name='cluster_MenuCmds') as c:
        c.attr(label='Menus and Scripts', style='filled', color='lavender')
        c.node('MtdtMenu', '\nMTDT-Distribution\nMenu\n', shape='rarrow', style='filled', fillcolor='salmon')
        c.node('lcntProcMailing', '\nlcntProc.sh\nMailing\n', shape='rarrow', style='filled', fillcolor='salmon3')

    # === Cluster: Sending ===
    with dot.subgraph(name='cluster_Sending') as c:
        c.attr(label='Sending Logic', style='filled', color='azure')
        c.node('doSend', 'doSend', shape='rect', style='filled', fillcolor='azure3')
        c.node('unsentBuf', 'unsentBuffer', shape='rect', style='filled', fillcolor='azure3')
        c.node('sendWithExtent', 'sendWithExtent', style='filled', fillcolor='darksalmon')
        c.node('unsentBuffer', 'Unsent\nMail\nBuffer', shape='invtrapezium', style='filled', fillcolor='deepskyblue')
        c.node('sent', '\nResident\nMTA\n(MARMEE)\n', shape='cds', style='filled', fillcolor='cyan')

    # === Cluster: Recipients and Lists ===
    with dot.subgraph(name='cluster_Recipients') as c:
        c.attr(label='Recipients & Addressing', style='filled', color='lightyellow')
        c.node('Recipients', 'Recipients', style='filled', fillcolor='khaki1')
        c.node('RecipientsList', 'Recipients List', style='filled', fillcolor='khaki1')
        c.node('RecipientsListForm', 'Recipients List Form', style='filled', fillcolor='khaki1')
        c.node('RecipientsListFormFile', 'Selected\nRecipients\nList\nForm\n File', style='filled', fillcolor='green')
        c.node('bbdb2', 'bbdb2', style='filled', fillcolor='khaki1')
        c.node('bbdb3', 'bbdb3', style='filled', fillcolor='khaki1')
        c.node('NamesFile', 'namesFile', style='filled', fillcolor='khaki1')
        c.node('DistNamesFile', 'distNamesFile', style='filled', fillcolor='khaki1')

    # === Cluster: Logs ===
    with dot.subgraph(name='cluster_Logs') as c:
        c.attr(label='Tracking & Logs', style='filled', color='lightcyan')
        c.node('LogFile', 'logFile', style='filled', fillcolor='khaki1')

    # === Edges ===
    dot.edge('MTDT-Mailing', 'MailingFile', label='Specification')
    dot.edge('MailingFile', 'TemplateFile')
    dot.edge('MailingFile', 'MailingCmnd', label='Derive')
    dot.edge('TemplateFile', 'MailingCmnd', label='Derive')
    dot.edge('MailingCmnd', 'ListOfMailingCmnds')
    dot.edge('ListOfMailingCmnds', 'SelectedMailings')

    dot.edge('MTDT-Distribution', 'Interactive', label='Execution')
    dot.edge('MTDT-Distribution', 'SendExtent', label='Configuration')
    dot.edge('MTDT-Distribution', 'OorR', label='Machinary')
    dot.edge('MTDT-Distribution', 'AddressBook', label='Specification')
    dot.edge('MTDT-Distribution', 'Names', label='Specification')
    dot.edge('MTDT-Distribution', 'Distributions', label='Specification')
    dot.edge('MTDT-Distribution', 'Tracking', label='Machinary')

    dot.edge('SelectedMailings', 'MtdtMenu')
    dot.edge('Interactive', 'MtdtMenu')
    dot.edge('Interactive', 'lcntProcMailing')
    dot.edge('MtdtMenu', 'sendWithExtent')
    dot.edge('lcntProcMailing', 'sendWithExtent')
    dot.edge('sendWithExtent', 'unsentBuffer')
    dot.edge('sendWithExtent', 'sent')
    dot.edge('unsentBuffer', 'sent')

    dot.edge('SendExtent', 'doSend', dir='back', label='Enum')
    dot.edge('SendExtent', 'unsentBuf', dir='back', label='Enum')
    dot.edge('SendExtent', 'sendWithExtent', label='inform')

    dot.edge('OorR', 'Recipients')
    dot.edge('Recipients', 'RecipientsList')
    dot.edge('RecipientsList', 'RecipientsListForm')
    dot.edge('RecipientsListForm', 'RecipientsListFormFile')
    dot.edge('AddressBook', 'bbdb2')
    dot.edge('AddressBook', 'bbdb3')
    dot.edge('Names', 'NamesFile')
    dot.edge('NamesFile', 'bbdb2')
    dot.edge('bbdb2', 'RecipientsListFormFile')
    dot.edge('NamesFile', 'bbdb3')
    dot.edge('bbdb3', 'RecipientsListFormFile')
    dot.edge('RecipientsListFormFile', 'MtdtMenu')

    dot.edge('Distributions', 'DistNamesFile')
    dot.edge('DistNamesFile', 'RecipientsListFormFile')
    dot.edge('Tracking', 'LogFile')
    dot.edge('LogFile', 'Distributions')

    return dot

def clustered_mtdtConceptsGraph_l3() -> graphviz.Digraph:
    dot = graphviz.Digraph(
        comment='MTDT-Distribution Concepts',
    )

    with dot.subgraph(name='cluster_L1') as l1:
        l1.attr(label='LAYER 1 - Mailing Concepts', style='filled', color='lightgrey')
        l1.node('MTDT-Mailing', 'MTDT\nMailing\nConcepts\nLAYER 1', shape='circle', style='filled', fillcolor='darkseagreen3')
        l1.node('MailingFile', 'Mailing\nFile', shape='parallelogram', style='filled', fillcolor='khaki1')
        l1.node('TemplateFile', 'Template\nFile', shape='parallelogram', style='filled', fillcolor='khaki1')
        l1.node('MailingCmnd', 'Mailing\nCommand', shape='oval', style='filled', fillcolor='khaki1')
        l1.node('ListOfMailingCmnds', 'List of\nMailing\nCommand', shape='oval', style='filled', fillcolor='khaki1')
        l1.node('SelectedMailings', 'Selected\nList of\nMailings ', style='filled', fillcolor='green')

    with dot.subgraph(name='cluster_L2') as l2:
        l2.attr(label='LAYER 2 - Distribution Concepts', style='filled', color='lightyellow')
        l2.node('MTDT-Distribution', 'MTDT\nDistribution\nConcepts\nLAYER 2', shape='circle', style='filled', fillcolor='darkseagreen3')
        l2.node('OorR', 'Orig Or Recipients', shape='cylinder', style='filled', fillcolor='khaki1')
        l2.node('SendExtent', 'Selected\nSend\nExtent', style='filled', fillcolor='green')
        l2.node('doSend', 'doSend', shape='rect', style='filled', fillcolor='azure3')
        l2.node('unsentBuf', 'unsentBuffer', shape='rect', style='filled', fillcolor='azure3')
        l2.node('Recipients', 'Recipients', style='filled', fillcolor='khaki1')
        l2.node('RecipientsList', 'Recipients List', style='filled', fillcolor='khaki1')
        l2.node('RecipientsListForm', 'Recipients List Form', style='filled', fillcolor='khaki1')
        l2.node('RecipientsListFormFile', 'Selected\nRecipients\nList\nForm\n File', style='filled', fillcolor='green')
        l2.node('sendWithExtent', 'sendWithExtent', style='filled', fillcolor='darksalmon')
        l2.node('unsentBuffer', 'Unsent\nMail\nBuffer', shape='invtrapezium', style='filled', fillcolor='deepskyblue')
        l2.node('sent', '\nResident\nMTA\n(MARMEE)\n ', shape='cds', style='filled', fillcolor='cyan')

    with dot.subgraph(name='cluster_L3') as l3:
        l3.attr(label='LAYER 3 - Share Concepts', style='filled', color='lightblue')
        l3.node('MTDT-Share', 'MTDT\nShare\nConcepts\nLAYER 3', shape='circle', style='filled', fillcolor='darkseagreen3')
        l3.node('Interactive', 'Interactive\nUsage', shape='circle', style='filled', fillcolor='darksalmon')
        l3.node('BrowserShare', '\nBrowser\nShare\n ', shape='rarrow', style='filled', fillcolor='salmon')
        l3.node('DiredShare', '\nDired\nShare\n ', shape='rarrow', style='filled', fillcolor='salmon3')

    # L1 Edges
    dot.edge('MTDT-Mailing', 'MailingFile', label='Specification')
    dot.edge('MailingFile', 'TemplateFile')
    dot.edge('MailingFile', 'MailingCmnd', label='Derive')
    dot.edge('TemplateFile', 'MailingCmnd', label='Derive')
    dot.edge('MailingCmnd', 'ListOfMailingCmnds')
    dot.edge('ListOfMailingCmnds', 'SelectedMailings')

    # L2 Edges
    dot.edge('MTDT-Distribution', 'SendExtent', label='Configuration')
    dot.edge('MTDT-Distribution', 'OorR', label='Machinary')
    dot.edge('sendWithExtent', 'unsentBuffer')
    dot.edge('sendWithExtent', 'sent')
    dot.edge('unsentBuffer', 'sent')
    dot.edge('SendExtent', 'doSend', dir='back', label='Enum')
    dot.edge('SendExtent', 'unsentBuf', dir='back', label='Enum')
    dot.edge('SendExtent', 'sendWithExtent', label='inform')
    dot.edge('OorR', 'Recipients')
    dot.edge('Recipients', 'RecipientsList')
    dot.edge('RecipientsList', 'RecipientsListForm')
    dot.edge('RecipientsListForm', 'RecipientsListFormFile')

    # L3 Edges
    dot.edge('MTDT-Share', 'Interactive', label='Execution')
    dot.edge('SelectedMailings', 'BrowserShare')
    dot.edge('SelectedMailings', 'DiredShare')
    dot.edge('RecipientsListFormFile', 'BrowserShare')
    dot.edge('RecipientsListFormFile', 'DiredShare')
    dot.edge('Interactive', 'BrowserShare')
    dot.edge('Interactive', 'DiredShare')
    dot.edge('BrowserShare', 'sendWithExtent')
    dot.edge('DiredShare', 'sendWithExtent')

    return dot


####+BEGIN: b:py3:cs:orgItem/basic :type "=Seed Setup= " :title "*Common Facilities*" :comment "General"
""" #+begin_org
*  _[[elisp:(blee:menu-sel:outline:popupMenu)][±]]_ _[[elisp:(blee:menu-sel:navigation:popupMenu)][Ξ]]_ [[elisp:(outline-show-branches+toggle)][|=]] [[elisp:(bx:orgm:indirectBufOther)][|>]] *[[elisp:(blee:ppmm:org-mode-toggle)][|N]]*  =Seed Setup=  [[elisp:(outline-show-subtree+toggle)][||]] *Common Facilities* General  [[elisp:(org-cycle)][| ]]
#+end_org """
####+END:


namedGraphsList = [
    ng("mtdtConceptsGraphClustered", func=mtdtConceptsGraphClustered),
    ng("mtdtConceptsGraph", func=mtdtConceptsGraph),   #
    ng("mtdtConceptsGraph_l0", func=mtdtConceptsGraph_l0),   #
    ng("clustered_mtdtConceptsGraph_l0", func=clustered_mtdtConceptsGraph_l0),   ##
    ng("mtdtConceptsGraph_l1", func=mtdtConceptsGraph_l1),   #
    ng("clustered_mtdtConceptsGraph_l1", func=clustered_mtdtConceptsGraph_l1),   ##
    ng("mtdtConceptsGraph_l2", func=mtdtConceptsGraph_l2),   #
    ng("clustered_mtdtConceptsGraph_l2", func=clustered_mtdtConceptsGraph_l2),   #
    ng("mtdtConceptsGraph_l3", func=mtdtConceptsGraph_l3),   #
    ng("clustered_mtdtConceptsGraph_l3", func=clustered_mtdtConceptsGraph_l3),   ##
]


graphvizSeed.setup(
    seedType="common",
    namedGraphsList=namedGraphsList,
    # examplesHook=qmail_binsPrep.examples_csu,
)

####+BEGIN: b:py3:cs:seed/withWhich :seedName "seedGraphviz.cs"
""" #+begin_org
*  _[[elisp:(blee:menu-sel:outline:popupMenu)][±]]_ _[[elisp:(blee:menu-sel:navigation:popupMenu)][Ξ]]_ [[elisp:(outline-show-branches+toggle)][|=]] [[elisp:(bx:orgm:indirectBufOther)][|>]] *[[elisp:(blee:ppmm:org-mode-toggle)][|N]]*  seed       [[elisp:(outline-show-subtree+toggle)][||]] <<seedGraphviz.cs>>   [[elisp:(org-cycle)][| ]]
#+end_org """
import shutil
import os

seedName = 'seedGraphviz.cs'
seedFullPath = os.path.abspath(shutil.which(seedName))

__file__ = seedFullPath
with open(__file__) as f:
    exec(compile(f.read(), __file__, 'exec'))

####+END:
