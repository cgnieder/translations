% --------------------------------------------------------------------------
% the TRANSLATIONS package
% 
%   internationalization of LaTeX packages
% 
% --------------------------------------------------------------------------
% Clemens Niederberger
% Web:    https://github.com/cgnieder/translations
% E-Mail: clemens@cnltx.de
% --------------------------------------------------------------------------
% Copyright 2012--2022 Clemens Niederberger
% 
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3c
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2008/05/04 or later.
% 
% The Current Maintainer of this work is Clemens Niederberger.
% --------------------------------------------------------------------------
\ProvidesClass{translations-manual}[2022/03/27]

\PassOptionsToPackage{ngerman,english}{babel}
\LoadClass[load-preamble,add-index]{cnltx-doc}

\setcnltx{
  package  = {translations} ,
  authors  = Clemens Niederberger ,
  email    = clemens@cnltx.de ,
  url      = https://github.com/cgnieder/translations ,
  info     = {Internationalization of \LaTeX\ Packages} ,
  add-cmds = {
    baselanguage,
    DeclareDictTranslation,
    DeclareLanguage,
    DeclareLanguageAlias,
    DeclareLanguageDialect,
    DeclareTranslation,
    declaretranslation,
    DeclareTranslationFallback,
    declaretranslationfallback,
    definetranslation,
    definetranslationfallback,
    GetTranslation,
    GetTranslationFor,
    ifcurrentbaselang,
    ifcurrentlang,
    IfTranslation,
    LoadDictionary,
    LoadDictionaryFor,
    NewTranslation,
    NewTranslationFallback,
    ProvideDictionaryFor,
    ProvideDictTranslation,
    ProvideTranslation,
    addtranslation,
    ProvideTranslationFallback,
    addtranslationfallback,
    RenewTranslation,
    redefinetranslation,
    RenewTranslationFallback,
    redefinetranslationfallback,
    SaveTranslation,
    SaveTranslationFor,
    thelanguage
  } ,
  add-silent-cmds = {
    cuisine,kitchen,mypackage@title
  } ,
  makeindex-setup = {options={-s cnltx.ist},columns=2,columnsep=1em} ,
  index-setup = {othercode=\footnotesize,level=\section}
}

\microtypesetup{tracking=scshape}

\RequirePackage[
  backend=biber,
  style=cnltx,
  sortlocale=en_US,
  indexing=cite]{biblatex}
\addbibresource{cnltx.bib}

\RequirePackage[biblatex]{embrac}
\ChangeEmph{[}[,.02em]{]}[.055em,-.08em]
\ChangeEmph{(}[-.01em,.04em]{)}[.04em,-.05em]
\RequirePackage{csquotes}

\defbibheading{bibliography}{\section{References}}

\RequirePackage{array,longtable,booktabs}
\AtEndPreamble{\RequirePackage[sort]{cleveref}}
\RequirePackage{bbding}

\ExplSyntaxOn
\ProvideDocumentCommand \intmod {mm} { \int_mod:nn {#1} {#2} }
\ExplSyntaxOff

\renewcommand*\meta[1]{%
  $\langle$\textcolor{meta}{{\argumentformat#1\/}}$\rangle$%
}

\RequirePackage{fontawesome}
\RequirePackage{datetime2}
\DTMsetup{useregional=numeric,datesep=/}
\newcounter{trnslt@ver}
\newrobustcmd*\trnslt@add@version[3]{%
  \stepcounter{trnslt@ver}%
  \csdef{trnslt@ver@#2}{%
    \DTMdate{#1}%
    \csgdef{trnslt@ver@#2used}{}%
    \csdef{trnslt@ver@#2}{\DTMdate{#1}}%
  }%
  \csdef{trnslt@ver@\roman{trnslt@ver}@date}{\DTMdate{#1}}%
  \csdef{trnslt@ver@\roman{trnslt@ver}@ver}{#2}%
  \csdef{trnslt@ver@\roman{trnslt@ver}@info}{#3}%
}
\RequirePackage{enumitem}

\newrobustcmd\versionhistory{%
  \begingroup
  \renewenvironment{commands}{%
    \def\cmd####1{\item\cs{####1}}%
    \def\explcmd####1{\item\explcs{####1}}%
    \itemize[nosep]%
  }{\enditemize}%
  \setcounter{cnltx@tmpa}{0}%
  \whileboolexpr{
    test {\ifnumless{\value{cnltx@tmpa}}{\value{trnslt@ver}}}
  }{%
    \stepcounter{cnltx@tmpa}%
    \subsection*{v\csuse{trnslt@ver@\roman{cnltx@tmpa}@ver}
      (\csuse{trnslt@ver@\roman{cnltx@tmpa}@date})}
    \begin{itemize}[nosep]
      \item \csuse{trnslt@ver@\roman{cnltx@tmpa}@info}
    \end{itemize}
  }
  \endgroup
}

\newrobustcmd*\issue[1]{%
  \href{https://github.com/cgnieder/translations/issues/#1}{issue \##1}%
}

\newrobustcmd*\trnslt@date[1]{\ifcsdef{trnslt@ver@#1used}{}{ (\csuse{trnslt@ver@#1})}}
\newrobustcmd*\trnslt@ifnew[1]{\ifcsstring{c_trnslt_version_tl}{#1}}
\newrobustcmd*\trnslt@NEW{\faStarO\ New}

\renewrobustcmd*\sinceversion[1]{%
  \trnslt@ifnew{#1}%
    {\cnltx@version@note{\textcolor{red}{\trnslt@NEW}}}%
    {\cnltx@version@note{\GetTranslation{cnltx-introduced}~v#1\trnslt@date{#1}}}%
}
\renewrobustcmd*\changedversion[1]{%
  \cnltx@version@note{\GetTranslation{cnltx-changed}~v#1\trnslt@date{#1}}%
}

\newnote*\sincechanged[2]{%
  \GetTranslation{cnltx-introduced}~#1\trnslt@date{#1},
  changed with ~v#2\trnslt@date{#2}\trnslt@ifnew{#2}{ \trnslt@NEW}{}%
}

\newcommand*\TF{\textcolor{red}{\uline{\code{\textcolor{cs}{\textit{TF}}}}}}
\newrobustcmd*\explcsformat[1]{%
  \code{\textbackslash\textcolor{cs}{\detokenize{#1}}}%
}
\newidxcmd\explcs{\explcsformat{#1}}[ (expl3)]
\cnltx@deflistitem{\cnltx@explcommand}{\explcs}

\NewDocumentEnvironment{explcommands}{}
  {%
    \let\command\cnltx@explcommand
    \cnltxlist
  }
  {\endcnltxlist}

\RequirePackage{tcolorbox,xsimverb}
\tcbuselibrary{skins,breakable}
\tcbset{enhanced,enhanced jigsaw}

\newtcolorbox{bewareofthedog}{
  colback  = red!2!white!98 ,
  colframe = red ,
  underlay={%
    \path[draw=none]
      (interior.south west)
      rectangle node[red]{\Huge\bfseries !}
      ([xshift=-4mm]interior.north west);
    }%
}

\newtcolorbox{cnltxcode}[1][]{
  boxrule = 1pt ,
  colback = cnltxbg ,
  colframe = cnltx ,
  arc = 5pt ,
  beforeafter skip = .5\baselineskip ,%
  #1%
}

\newcommand*\trnsltman@readoptions[1]{%
  \catcode`\^^M=13
  \trnsltman@read@options{#1}%
}

\begingroup
\catcode`\^^M=13
\gdef\trnsltman@read@options#1#2^^M{%
  \endgroup
  \ifblank{#2}{}{\trnsltman@read@options@#2}%
  #1%
  \XSIMfilewritestart*{\jobname.tmp}%
}%
\endgroup
\def\trnsltman@read@options@[#1]{\pgfqkeys{/cnltx}{#1}}

\RenewDocumentEnvironment{sourcecode}{}
  {%
    \begingroup
    \trnsltman@readoptions{%
      \setlength\cnltx@sidebysidewidth
        {\dimexpr .45\columnwidth -\lst@xleftmargin -\lst@xrightmargin\relax}%
      \expanded{%
        \noexpand\lstset{
          style=cnltx,
          \ifboolexpe{ bool {cnltx@sidebyside} and not bool {cnltx@codeonly} }
            {linewidth=\cnltx@sidebysidewidth,}{}%
          \expandonce\cnltx@local@listings@options
        }%
      }%
      \XSIMgobblechars{2}%
    }%
  }
  {%
    \XSIMfilewritestop
    \cnltxcode[breakable]%
    \lstinputlisting[style=cnltx]{\jobname.tmp}%
    \endcnltxcode
  }

\RenewDocumentEnvironment{example}{!o}{%
  \setlength\cnltx@sidebysidewidth
    {\dimexpr .45\columnwidth -\lst@xleftmargin -\lst@xrightmargin\relax}%
  \expanded{%
    \noexpand\lstset{
      style=cnltx,
      \ifboolexpe{ bool {cnltx@sidebyside} and not bool {cnltx@codeonly} }
        {linewidth=\cnltx@sidebysidewidth,}{}%
      \expandonce\cnltx@local@listings@options
    }%
  }%
  \XSIMgobblechars{2}%
  \IfValueT{#1}{\pgfqkeys{/cnltx}{#1}}%
  \ifbool{cnltx@compile}{%
    \stepcounter{cnltx@filenumber}%
    \IfNoValueTF{#1}
      {\XSIMfilewritestart*{\jobname-cnltx-\arabic{cnltx@filenumber}.tex}}
      {\XSIMfilewritestart{\jobname-cnltx-\arabic{cnltx@filenumber}.tex}}%
  }{%
    \IfNoValueTF{#1}
      {\XSIMfilewritestart*{\jobname.tmp}}
      {\XSIMfilewritestart{\jobname.tmp}}%
  }%
}{%
  \XSIMfilewritestop
  \ifbool{cnltx@compile}
    {% compile file and include document
      \cnltx@ifshellescape
        {%
          \cnltx@example@info
            {%
              Compiling example `\jobname-cnltx.tex' \arabic{cnltx@runs}
              time\ifnum\value{cnltx@runs}>1s\fi\space with
              \cnltx@compilation@methods
            }%
          \cnltx@expandargs(no)\forcsvlist
            {\cnltx@compilation@process{\jobname-cnltx-\arabic{cnltx@filenumber}.tex}}
            {\cnltx@compilation@methods}%
        }
        {%
          \cnltx@example@warning
            {`shell-escape' or `write18' not enabled -- I'm  not compiling}%
        }%
    }{}%
  \ifbool{cnltx@sidebyside}{%
    \cnltxcode
    \noindent
    \minipage[c]{\cnltx@sidebysidewidth}%
      \cnltx@pre@source@hook
      \ifbool{cnltx@compile}
        {\lstinputlisting[style=cnltx]{\jobname-cnltx-\arabic{cnltx@filenumber}.tex}}
        {\lstinputlisting[style=cnltx]{\jobname.tmp}}%
      \cnltx@after@source@hook
    \endminipage\hfill
    \minipage[c]{\cnltx@sidebysidewidth}%
      \cnltx@pre@example@hook
      \ifbool{cnltx@compile}
        {\cnltx@input@pdf{\jobname-cnltx-\arabic{cnltx@filenumber}}}
        {\input{\jobname.tmp}}%
      \cnltx@after@example@hook
    \endminipage
  }{%
    \cnltxcode[breakable]%
    \cnltx@pre@source@hook
      \ifbool{cnltx@compile}
        {\lstinputlisting[style=cnltx]{\jobname-cnltx-\arabic{cnltx@filenumber}.tex}}
        {\lstinputlisting[style=cnltx]{\jobname.tmp}}%
    \cnltx@after@source@hook
    \tcblower
    \cnltx@pre@example@hook
    \ifbool{cnltx@compile}
      {\cnltx@input@pdf{\jobname-cnltx-\arabic{cnltx@filenumber}}}
      {\input{\jobname.tmp}}%
    \cnltx@after@example@hook
  }%
  \endcnltxcode
}

\newrobustcmd*\cnltx@input@pdf[1]{%
  \IfFileExists{#1.pdf}{%
    \cnltx@get@pdfpages{#1.pdf}%
    \setcounter{cnltx@tmpa}{1}%
    \setcounter{cnltx@tmpb}{\value{cnltx@pdfpages}}%
    \ifbool{cnltx@pagelist}{%
      \setcounter{cnltx@tmpa}{0}%
      \forlistloop
        {\cnltx@stepcounter@ifnotempty{cnltx@tmpa}}
        \cnltx@pagelist
      \ifnumgreater{\value{cnltx@tmpa}}{1}
        {\noindent}
        {\centering}%
      \forlistloop
        {\cnltx@print@documentpage{#1.pdf}{\value{cnltx@tmpa}}}
        \cnltx@pagelist
    }{%
      \ifnumequal{\value{cnltx@pdfpages}}{1}
        {\centering}
        {\noindent}%
      \whileboolexpr
        { test {\ifnumgreater{\value{cnltx@tmpb}}{0}} }
        {%
          \cnltx@print@documentpage
            {#1.pdf}
            {\value{cnltx@pdfpages}}
            {\value{cnltx@tmpa}}%
          \stepcounter{cnltx@tmpa}%
          \setcounter{cnltx@tmpb}{\numexpr\value{cnltx@tmpb}-1\relax}%
      }%
    }%
  }%
}

\newcommand*\trnslt@ifstar@gobble[1]{%
  \ifx*#1%
    \expandafter\@firstoftwo
  \else
    \expandafter\@secondoftwo
  \fi
}
  
\newrobustcmd*\pdfdisable[2]{%
  \csdef{trnslt@@\cnltx@stripbs#1}##1{#2}%
  \def#1##1{%
    \trnslt@ifstar@gobble{##1}%
      {\csuse{trnslt@@\cnltx@stripbs#1}}%
      {\csuse{trnslt@@\cnltx@stripbs#1}{##1}}%
  }%
}

\AtEndPreamble{%
  \pdfstringdefDisableCommands{%
    \pdfdisable\cs{\string\\#1}%
    \pdfdisable\cmd{\string\\#1}%
    \pdfdisable\option{#1}%
    \def\oarg#1{[<#1>]}%
    \def\Oarg#1{[#1]}%
    \def\marg#1{\{<#1>\}}%
    \def\Marg#1{\{#1\}}%
    \def\acro{acro}%
    \def\LaTeX{LaTeX}%
    \def\TeX{TeX}%
  }%
}

% version history:
% v0.
\trnslt@add@version{2012-09-30}{0.2beta}{first version (as part of the
  \pkg{exsheets} bundle)}
\trnslt@add@version{2012-10-05}{0.2}{\cs{LoadDictionary} and
  \cs{LoadDictionaryFor} added and loads of languages defined.}
\trnslt@add@version{2013-03-10}{0.8}{basic dictionaries for English, German,
  French and Spanish \item new command \cs{DeclareDictTranslation}}
\trnslt@add@version{2013-04-04}{0.8a}{bug fix in \cs{DeclareDictTranslation}}
\trnslt@add@version{2013-04-07}{0.9}{slightly improved messages}
\trnslt@add@version{2013-04-08}{0.9a}{changed fallback warning into info \item
  synchronized version number with \pkg{exsheets} until now but won't any more}
\trnslt@add@version{2013-06-22}{0.9b}{added Swiss}
\trnslt@add@version{2013-06-28}{0.10}{declaring aliases of dialects now works
  as expected \item declarings dialects of an alias now correctly declares the
  dialect to the correct base language \item corrected a few erroneous
  language declarations}
\trnslt@add@version{2013-07-12}{0.10a}{\cs{GetTranslation} gets two-fold
  fallback: use fallback translation if no translation for the current
  language has been defined; use literal string if \emph{no} language is used
  -- this should never happen but we all know that it \emph{will} happen
  eventually}

% v1.
\trnslt@add@version{2013-07-16}{1.0}{removed from \pkg{exsheets} bundle --
  \translations\ should be a package of it's own\item load basic dictionary
  automatically if available \item rudimentary check in \cs{LoadDictionary} if
  loaded file is a dictionary \item new command \cs{PrintDictionaryFor} \item
  redefined conditionals; they still seemed to make trouble in some cases}
\trnslt@add@version{2013-08-05}{1.1}{added \emph{loads} of languages, now the
  list of \pkg{babel} and \pkg{polyglossia} languages hopefully is
  complete\item a few languages had falsely been declared as dialect instead
  of an alias \item added weekday names and month names to basic
  dictionary \item new command \cs{baselanguage} \item new commands
  \cs{GetLCTranslation}, \cs{GetLCTranslationFor}, \cs{GetLCTranslationWarn}
  and \cs{GetLCTranslationForWarn} \item load basic dictionary also for
  dialects and if it doesn't exist load it for the corresponding base language
  instead}
\trnslt@add@version{2013-09-30}{1.1a}{Bug fix in \cs{NewTranslation} und
  \cs{RenewTranslation}}
\trnslt@add@version{2014-01-10}{1.2}{\cs{ifcurrentlanguage},
  \cs{ifcurrentbaselanguage} \item require \pkg{cnltx-base} \item change the
  \enquote{no language package} warning into an info \item
  \cs{ProvideTranslation} \item \cs{NewDictTranslation},
  \cs{RenewDictTranslation}, \cs{ProvideDictTranslation} \item translations in
  dictionaries are provided \item \cs{baselanguagename}}
\trnslt@add@version{2014-01-23}{1.2a}{add \cs*{detokenize} so that translation
  keys with non-ascii chars can safely be used \item fix bug in dialect
  declaration \item rename \cs{baselanguagename} into \cs{baselanguage} \item
  drop earlier \cs{baselanguage} (it was and still is available as
  \cs*{@trnslt@language})}
\trnslt@add@version{2015-07-09}{1.2b}{add Korean}
\trnslt@add@version{2015-08-29}{1.2c}{fix bug in
  \cs*{@trnslt@save@translation@for}}
\trnslt@add@version{2015-09-06}{1.2d}{add alias slovene for slovenian \item
  add user command for \cs*{@trnslt@if@translation}}
\trnslt@add@version{2015-11-07}{1.2e}{Some fixes to the French translations in
  the basic dictionary, thanks to Denis Bitouz\'e \item add Macedonian
  language}
\trnslt@add@version{2016-04-19}{1.3}{\cs{LoadDictionary} first checks if a
  dictionary for the  dialect exists and loads it if it does; else it looks
  for a dictionary of the base language and loads that instead \item New
  command \cs{LoadDictionaryForDialect} which only loads the dictionary for a
  specified dialect -- this doesn't check if a dictionary for a base language
  exists}
\trnslt@add@version{2016-06-02}{1.4}{%
  new commands
  \begin{commands}
    \cmd{declaretranslation}
    \cmd{newtranslation}
    \cmd{renewtranslation}
    \cmd{providetranslation}
  \end{commands}
  which can be used after begin document \item fallback versions for each
  definition command}
\trnslt@add@version{2016-06-02}{1.4a}{rename new commands: they conflict with
  the \pkg{translator} package!}
\trnslt@add@version{2017-03-03}{1.5}{remove dependency on
  \pkg{cnltx-base} \item add Dutch dictionary (thanks to kwikwi) \item add
  Catalan dictionary (thanks to kwikwi)}
\trnslt@add@version{2017-03-05}{1.5a}{correct typos in Dutch dictionary}
\trnslt@add@version{2017-04-24}{1.5b}{correct typos in Malaysian language names}
\trnslt@add@version{2017-05-06}{1.5c}{add Azerbaijani}
\trnslt@add@version{2017-05-16}{1.6}{allow translations to contain
  \cs*{par} \item improve perfomance by replacing list checks}
\trnslt@add@version{2017-07-03}{1.6a}{fix \issue{6} (bug in
  \cs*{@trnslt@save@translation@for})}
\trnslt@add@version{2017-07-06}{1.7}{return translation values in
  \cs*{unexpanded}}
\trnslt@add@version{2017-08-31}{1.7a}{add missing dependency on
  \pkg{pdftexcmds}}
\trnslt@add@version{2020-02-28}{1.8}{load basic dictionary for each loaded
  language (if available)}
\trnslt@add@version{2020-04-26}{1.8a}{fix problem with loading of dictionaries
  in some circumstances}
\trnslt@add@version{2020-04-28}{1.8b}{fix \issue{9}}
\trnslt@add@version{2020-11-08}{1.9}{add
  \cs{ifcurrentlang}\marg{lang}\code{...}\cs*{else}\code{...}\cs*{fi} \item
  add
  \cs{ifcurrentbaselang}\marg{lang}\code{...}\cs*{else}\code{...}\cs*{fi}\item
  add Brazilian basic dictionary}
\trnslt@add@version{2021-01-16}{1.10}{remove \pkg{scrlfile} dependency}
\trnslt@add@version{2021-01-16}{1.10a}{correct bug from last update}
\trnslt@add@version{2022-01-04}{1.11}{fix \issue{18} \item undo v1.7, fixes
  \issue{12} \item make nynorsk a dialect of norsk, fixes \issue{19} \item
  don't define the literal string as command but output it directly, fixes
  \issue{13} \item correct some Dutch translations}
\trnslt@add@version{2022-02-05}{1.12}{add Polish translations, thanks to Jacub
  Kaczor}

% v2.
\trnslt@add@version{2022-03-28}{2.0}{%
  package re-written in expl3
  \item new commands:
    \begin{commands}
      \explcmd{trnslt_show_translations:}
      \explcmd{trnslt_show_dictionary:nn}
    \end{commands}
  \item new commands:
    \begin{commands}
      \explcmd{trnslt_map_languages:n}
      \explcmd{trnslt_map_dialects:n}
      \explcmd{trnslt_map_aliases:n}
      \explcmd{trnslt_map_dictionary:nnn}
    \end{commands}
  \item new commands:
    \begin{commands}
      \explcmd{trnslt_translations_declare:nn}
      \explcmd{trnslt_language_translations_declare:nn}
    \end{commands}
  \item removed commands:
    \begin{commands}
      \cmd{PrintDictionaryFor}
      \cmd{LoadDictionaryForDialect}
      \cmd{GetLCTranslationFor}
      \cmd{GetLCTranslation}
      \cmd{GetLCTranslationForWarn}
      \cmd{GetLCTranslationWarn}
    \end{commands}
}
