#!/bin/osmtKsh
#!/bin/osmtKsh

typeset RcsId="$Id: lcaPloneRoadmap.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"

if [ "${loadFiles}X" == "X" ] ; then
    seedActions.sh -l $0 "$@"
    exit $?
fi


function vis_examples {
  typeset visLibExamples=`visLibExamplesOutput ${G_myName}`
 cat  << _EOF_
EXAMPLES:
${visLibExamples}
--- Information
${G_myName} -i versions
${G_myName} -i modelAndTerminology
${G_myName} -i help
${G_myName} -i howTos
${G_myName} -i ploneTips
${G_myName} -i pointersAndReferences
${G_myName} -i printPackage
_EOF_
}


function noArgsHook {
  vis_examples
}

function vis_todos {
 cat  << _EOF_
 
  PLONE TODOs
  ===========

_EOF_
}

function vis_versions {
 cat  << _EOF_
The output of:
dpkg -s plone 
-----------------------------------
Package: plone
Priority: optional
Section: web
Installed-Size: 40
Maintainer: Fabio Tranchitella <kobold@kobold.it>
Architecture: all
Source: zope-cmfplone
Version: 2.0.4-3
Replaces: plone2
Depends: zope-cmfplone (= 2.0.4-3)
Recommends: zope-externaleditor (>= 0.6), zope-cmfsin, zope-ttwtype, zope-speedpack, zope-epoz, zope-kupu, zope-plonearticle, zope-atcontenttypes, zope2.7-archetypes | zope-archetypes, zope-ploneerrorreporting
Suggests: zope-plonecollectorng, zope-cmfnewsletter, zope-cmfphoto, zope-cmfphotoalbum, zope-cmfforum, zope-cmfwiki, zope-cmfweblog
Conflicts: plone2
Description: content management system based on zope and cmf
 This is a metapackage that depends on the real plone package
 and recommends or suggests other packages that are typically
 installed and used with plone.
 Plone will be going through some name changes upstream, so
 installing this package on debian will ensure that you get the
 correct package(s) when the names change and as new plone-related
 packages are added to Debian's distribution.
 .
 Plone CMS aims to be a proper Content Management and Publishing
 system, sharing the same qualities as Teamsite, Livelink and Documentum.
 OODBMS, RDBMS, WEBDAV, FTP and XMLRPC integration out-of-the-box. Plone is
 built with Zope and CMF.  See http://plone.org/ for more information.

_EOF_
}

function vis_modelAndTerminology {
 cat  << _EOF_
 
   Terminology and Model:
   ======================



Objects Overview:
-----------------

_EOF_
}

function vis_help {
 cat  << _EOF_

  lcaPloneRoadmap.sh    -- This File. General Orientation and Information
  lcaPlone BinsPrep.sh  -- Prepare binary files for qmail/ezmlmplone
  lcaPloneServers.sh    -- For subject host, configure plone site
  lcaPloneAdmin.sh      -- Start, stop and other admin tasks
  lcaPloneDomains.sh    -- 
  lcaPloneDomainItems.site -- Plone domains item file

_EOF_
}

function vis_howTos {
 cat  << _EOF_

    Q) What 1st thing to do after zope installation?
       Create a zope instance:
       /usr/lib/zope2.7/bin/mkzopeinstance.py

    A) How Do I create a plone site?
       Go to Zope Management Interface (ZMI), i.e.
       http://<url/ip>:9673/manage
       After login, on the drop down menu, look for
       "Plone Site", click "Add" button.

    B) After installing zope, the Plone product is not there.
       Why?
       Maybe the plone product directory is not listed in
       zope.conf.  Visit the zope.conf file:
       /var/lib/zope2.7/instance/<instancename>/etc/zope.conf 
       Add/uncomment the following line:

products /usr/lib/zope2.7/lib/python/Products
products /usr/lib/zope/lib/python/Products
products $INSTANCE/Products

       Restart the zope.

    C) Forgot the admin passwd.  How to initialize the passwd?
       cd to instance directory
       /usr/lib/zope2.7/bin/zpasswd.py access

    D) How to customize Plone site look?
       Use the plone custom css.  Go to ZMI, click on 
       the plone site folder you want to customize, portal_skins,
       plone_styles, ploneCustom.css.  Click on the Customize button
       adn do all the edit there.

    E) Setting up plone with apache.

       Make sure the libproxy is loaded.  Add the following lines to httpd.conf


       LoadModule proxy_module /usr/lib/apache/1.3/libproxy.so  
       AddModule mod_proxy.c

       Within the <VirtualHost>
        ProxyPass / http://www.payk.net:9673/payknet/
        ProxyPassReverse / http://www.payk.net:9673/payknet/
        ProxyPass /misc_ http://www.payk.net:9673/misc_
        ProxyPass /p_ http://www.payk.net:9673/p_

       After that go to zmi and into the plone site folder.  Add SiteRoot object
       and fill the following:
       Base: http://www.payk.net/

INSTALLING HTML EDITOR (WYSIWYG)
================================

Make sure that zope-epoz and zope-archetypes are installed.
Go to a plone site, Plone Setup, Add/Remove Products.
Mark the epoz and archetypes, click install.
After that go to ZMI, portal_memberdata, click on Properties
tab. set wysiwyg_editor=Epoz, Save.
Now Epoz will be your default editor.

Create a new portlet 
====================
Go to ZMI of the plone site folder, add Page template.
Name it to be something like "portlet_somename".
Click on "Add and Edit" and delete the default page and
put the following on the top of the page:



<html xmlns:tal="http://xml.zope.org/namespaces/tal"
      xmlns:metal="http://xml.zope.org/namespaces/metal"
      i18n:domain="plone">

<body>
<div metal:define-macro="portlet">
    <div class="portlet" id="portlet-somename">
        <h5 i18n:translate="box_someothername">New to ByMemory?</h5>
        <div class="portletBody">
some text
        </div>
    </div>
</div>
</body>
</html>

Then click on Properties in ZMI, add the following to the left
or right slot:
   here/portlet_somename/macros/portlet


MAKING PAGE TEMPLATE TO BE INDEX_HTML
=====================================

Add the following lines at the top of your page template

------------------------

<html metal:use-macro="here/main_template/macros/master">

<body>

<div metal:fill-slot="main">

your text

</div>

</body>

</html>

-------------------------

Go to ZMI, click on the folder where the page template resided.
Click on the Properties tab.
Add a new property of type "lines" with the name "default_page"
then put the template id.

#### Removing "Small Text   Normal Text  Large Text" #####

From the ZMI > portal_actions 
Unclick "Visible" for Small Text, Normal Text, and Large Text
then click "Save"

#### Removing portal tabs and "Login" ########
From the ZMI > portal_skins > plone_templates > main_template
then click on "Customize"

Comment out (with <!-- and -->) the part for portal_tabs

<!-- <div....../macros/portals_tabs>
.....
</div> -->

#### Change main line length ####
From the ZMI > portal_skins > plone_styles > plone.css and click on "Customize"
Look for ".documentContent" and edit/add "width: 55px;"

#### Plone site backup & restore ####
For BAP's style backup, use bystarBatchBasic.sh -i backupPloneSite

For general purpose backup:
 1) Go to zope zmi (i.e. 198.62.92.28:9673/manage_main)
 2) Mark the one you want to backup and click "Import/Export"
    Click on "Export".  At the top of the screen, it will tell
    you where the exported file is.  The default directory is
     /var/lib/zope2.7/instance/default/var
    The filename will have an .zexp extension.
 3) To import that filename, put the file with .zexp extension
    in /var/lib/zope2.7/instance/default/import directory.
    Again go to zope zmi and click "Import/Export"
    Type in the filename.zexp in the Import area and click Import.

#### Update footer and colophon and header #####
Footer is the one with Copyright notice
Colophon is the one with "Powered by" -- right after the footer
Header is the one with 3 images (by* outside, copyleft, libre services)
The default file is in
portal_skins > plone_templates
To customize the footer, click on the footer, then Customize.
To customize the colophon, click on the colophon, then Customize.
To customize the header, click on the global_searchbox, then Customize.


To import an existing footer and colophon from other website,
use general export/import method.

To export the footer/colophon/global_searchbox:
- go to portal_skins/custom -- then mark "footer", then click Import/Export
- Use the default object ID (i.e. footer) then click on "Export"
  The saved file will be in the following dir (also showed at the top of the table
  right after you click Export): /var/lib/zope2.7/instance/default/var/footer.zexp
- Move the file (i.e. with ssh) to the host machine where you want the footer
  to be duplicated, and copy it to the following directory:
  /var/lib/zope2.7/instance/default/import
- Then login to the website where you want the new footer be
  ZMI > portal_skins > custom
  Click on Import/Export button, then type in footer.zexp in the
  Import area
- Do the same thing for the colophon.

#### Python Script HOWTO #####

We're using "Create an Account" in byname.net as an example of usage.

1. Create any form field that you need. 
   From ZMI -> account folder.  On the top RHS, choose
   "Formulator Form" from the drop down. 
    Then add that form (oneForm). In this example,
    id is oneForm
    Click on oneForm.
    Add a field.
    Select type of field from RHS.
    Say string field.
    Call ir firstName (title First Name).
    Add any other fields that are needed
   for your form.

2. Create a "Page Template" for the front-page
   From ZMI -> account folder.  On the top RHS, choose
   "Page Template" from the drop down (i.e. id: create_new.zpt)
    Zope Page Template.
    No file needed.
    Just add.

3. Inside  "create_new.zpt", the "Next" button will redirect
   to "step1" inside the common_pages Page Template.
   Inside the common_page template, there will be many steps
   use for the redirection...

4. By the time you come to the verification Python script,
   create one by choosing "Script (python)" from the drop
   down. 

5. The Python script will then calling the external script
   (i.e. byname_create_account_action).  Create this by using
   "External Method" form the drop down menu.
   Module name is the name of the external python script and
   Funtion Name is the main function inside that script.
   This external script is placed in the following directory:
   /var/lib/zope2.7/instance/default/Extensions
   With this external python, we can then call any bash script.

#### Style Sheet Enhancements .css #####

/manage_main

Portal Skins -> Plone Style -> plone.css 
 
Customize

#### CoreBlog HOWTO ####

In ZMI, drop-down to "COREBlog".  Give it a new id and title, then 
click "Add COREBlog"
Click on the id name that you just create.  You need to add some "Category"
before adding a new entry.  Click on the "Categories" tab, then click on
"Add Category" button.  After you create Category, you can add entry.

To prevent Trackback, click on the blog id through ZMI, and click on "Settings"
tab.  Tick on "Require Authentication". MB.

To prevent Trackback, click on the blog id through ZMI, and click on "Properties"
tab.  Tick on "hide_comment" and "hide_trackback"
_EOF_
}


function vis_ploneTips {
 cat  << _EOF_

Tips:

   1. Items must be published before they can be viewed by the public. Else they are only viewable by members.
   2. A default document in a folder is named \u201cindex_html\u201d
   3. Styles can be changed by using the product DIYPloneStyle
   4. It\u2019s much easier to use Structured Text within Plone rather than HTML

Syntax:

      Link: "Name of Link":http://url

      Image: "Alternative Name of Image":img:http://url or

             "Alternative Name of Image":img:shortname 

      Bold:   **Bolded Text**

      Italics:  *Italicized Text*

      Underline: _Underlined Text_ 

      More at: http://plone.org/documentation/how-to/structured-text-cheatsheet 

Adding New Tabs: http://plone.org/documentation/how-to/changing-tabs 

Changing default logo: http://plone.org/documentation/how-to/custom-logo 

Removing the Calendar Portlet:

      1. Go to "Plone Setup" --> Zope Management Interface 
      2. Click on the "Properties" tab on top 
      3. Delete the line: "here/portlet_calendar/macros/portlet" 
      4. Save changes

How to remove byline display to all non-members:

From the ZMI > portal_properties > site_properties > uncheck AllowAnonymousViewAbout.


http://plone.org/documentation/tutorial/where-is-what/whereiswhat

You can change any part of the template. They will go into the custom folder and be named the same thing.

For example if you edited "footer", it would be moved to the custom folder but as long as it is named the same thing, the site will use the custom one.

Adding a site: Add site by logging into "Manage" and choosing "Add Plone Site"

_EOF_
}


function vis_pointersAndReferences {
 cat  << _EOF_

mozilla -remote "openurl(file:///usr/share/doc//usr/share/doc/zope2.7)"
mozilla -remote "openurl(file:///usr/share/doc//usr/share/doc/zope-cmfplone)"

_EOF_
}

function vis_printPackage {
	a2ps -s2 lcaPloneRoadmap.sh lcaZopeServers.sh lcaPloneLib.sh lcaPloneDomains.sh lcaPloneAdmin.sh   lcaPloneUpload.sh lcaPloneBinsPrep.sh ../siteControl/nedaPlus/lcaZopeServerItems.site 
}
