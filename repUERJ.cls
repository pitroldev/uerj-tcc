% 17/05/2013
% Para fazer
% 1. providenciar a hifenacao para palavras com cedilha e acentos (UTF8)
% 2. consertar o problema de sublinar subsecoes com \uline

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{repUERJ}[2013/06/01 v7.0]

\RequirePackage{ifthen}
\RequirePackage[normalem]{ulem}
\RequirePackage{caption}
\RequirePackage[dvipsnames,svgnames]{xcolor}
\RequirePackage{pdfpages}
\RequirePackage{setspace}

\providecommand{\packagename}{repUERJ v7.0}

% refaz o comando do setspace
\renewcommand{\singlespacing}{\setstretch {\setspace@singlespace}}

\newcommand\@ptsize{}
\newif\if@restonecol
\newif\if@titlepage
\@titlepagetrue
\newif\if@openright
\if@compatibility\else
  \DeclareOption{a4paper}
    {\setlength\paperheight {297mm}%
     \setlength\paperwidth  {210mm}}
  \DeclareOption{a5paper}
    {\setlength\paperheight {210mm}%
     \setlength\paperwidth  {148mm}}
  \DeclareOption{b5paper}
    {\setlength\paperheight {250mm}%
     \setlength\paperwidth  {176mm}}
  \DeclareOption{letterpaper}
    {\setlength\paperheight {11in}%
     \setlength\paperwidth  {8.5in}}
  \DeclareOption{legalpaper}
    {\setlength\paperheight {14in}%
     \setlength\paperwidth  {8.5in}}
  \DeclareOption{executivepaper}
    {\setlength\paperheight {10.5in}%
     \setlength\paperwidth  {7.25in}}
  \DeclareOption{landscape}
    {\setlength\@tempdima   {\paperheight}%
     \setlength\paperheight {\paperwidth}%
     \setlength\paperwidth  {\@tempdima}}
\fi
\if@compatibility
  \renewcommand\@ptsize{0}
\else
  \DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\fi
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\if@compatibility\else
  \DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\fi
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\if@compatibility\else
  \DeclareOption{final}{\setlength\overfullrule{0pt}}
\fi
\DeclareOption{titlepage}{\@titlepagetrue}
\if@compatibility\else
  \DeclareOption{notitlepage}{\@titlepagefalse}
\fi
\if@compatibility\else
  \DeclareOption{openright}{\@openrighttrue}
  \DeclareOption{openany}{\@openrightfalse}
\fi
\if@compatibility\else
  \DeclareOption{onecolumn}{\@twocolumnfalse}
\fi
\DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{openbib}{%
  \AtEndOfPackage{%
    \renewcommand\@openbib@code{%
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep \z@
      }%
    \renewcommand\newblock{\par}}%
}
%\ExecuteOptions{a4paper,12pt,oneside,onecolumn,final,openany}
\ProcessOptions
\input{size1\@ptsize.clo}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\setlength\parskip{0\p@ \@plus \p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\setcounter{topnumber}{2}
\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.3}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}
\if@twoside
  \def\ps@headings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\thepage\hfil\slshape\leftmark}%
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markboth {\MakeUppercase{%
        \ifnum \c@secnumdepth >\m@ne
            \@chapapp\ \thechapter. \ %
        \fi
        ##1}}{}}%
    \def\sectionmark##1{%
      \markright {\MakeUppercase{%
        \ifnum \c@secnumdepth >\z@
          \thesection. \ %
        \fi
        ##1}}}}
\else
  \def\ps@headings{%
    \let\@oddfoot\@empty
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markright {\MakeUppercase{%
        \ifnum \c@secnumdepth >\m@ne
            \@chapapp\ \thechapter. \ %
        \fi
        ##1}}}}
\fi

\def\ps@UERJ{%
  \let\@oddfoot\@empty
  \def\@oddhead{\hfil\thepage}%
}

\def\ps@myheadings{%
  \let\@oddfoot\@empty\let\@evenfoot\@empty
  \def\@evenhead{\thepage\hfil\slshape\leftmark}%
  \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
  \let\@mkboth\@gobbletwo
  \let\chaptermark\@gobble
  \let\sectionmark\@gobble}

\if@titlepage
  \newcommand\maketitle{
    \begin{titlepage}%
      \let\footnotesize\small
      \let\footnoterule\relax
      \let \footnote \thanks
      \null\vfil
      \vskip 60\p@
      \begin{center}%
        {\LARGE \@title \par}%
        \vskip 3em%
        {\large
         \lineskip .75em%
          \begin{tabular}[t]{c}%
            \@author
          \end{tabular}\par}%
          \vskip 1.5em%
        {\large \@date \par}%       % Set date in \large size.
      \end{center}\par
      \@thanks
      \vfil\null
    \end{titlepage}%
    \setcounter{footnote}{0}%
    \global\let\thanks\relax
    \global\let\maketitle\relax
    \global\let\@thanks\@empty
    \global\let\@author\@empty
    \global\let\@date\@empty
    \global\let\@title\@empty
    \global\let\title\relax
    \global\let\author\relax
    \global\let\date\relax
    \global\let\and\relax
  }
\else
  \newcommand\maketitle{\par
    \begingroup
      \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
      \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
      \long\def\@makefntext##1{\parindent 1em\noindent
              \hb@xt@1.8em{%
                  \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
      \if@twocolumn
        \ifnum \col@number=\@ne
          \@maketitle
        \else
          \twocolumn[\@maketitle]%
        \fi
      \else
        \newpage
        \global\@topnum\z@   % Prevents figures from going at top of page.
        \@maketitle
      \fi
      \thispagestyle{plain}\@thanks
    \endgroup
    \setcounter{footnote}{0}%
    \global\let\thanks\relax
    \global\let\maketitle\relax
    \global\let\@maketitle\relax
    \global\let\@thanks\@empty
    \global\let\@author\@empty
    \global\let\@date\@empty
    \global\let\@title\@empty
    \global\let\title\relax
    \global\let\author\relax
    \global\let\date\relax
    \global\let\and\relax
  }
  \def\@maketitle{%
    \newpage
    \null
    \vskip 2em%
    \begin{center}%
    \let \footnote \thanks
      {\LARGE \@title \par}%
      \vskip 1.5em%
      {\large
        \lineskip .5em%
        \begin{tabular}[t]{c}%
          \@author
        \end{tabular}\par}%
      \vskip 1em%
      {\large \@date}%
    \end{center}%
    \par
    \vskip 1.5em}
\fi

\newcommand*\chaptermark[1]{}

\setcounter{secnumdepth}{3}

\newcounter {part}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand \thepart {\@Roman\c@part}
\renewcommand \thechapter {\@arabic\c@chapter}
\renewcommand \thesection {\thechapter.\@arabic\c@section}
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection.\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}

\newcommand{\frontmatter}{\pagestyle{empty}\onehalfspacing}
\newcommand{\mainmatter}{\pagestyle{UERJ}\onehalfspacing}
\newcommand{\backmatter}{\onehalfspacing}

\newcommand\@chapapp{\chaptername}

\newcommand\part{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \thispagestyle{UERJ}%
  \if@twocolumn
    \onecolumn
    \@tempswatrue
  \else
    \@tempswafalse
  \fi
  \null\vfil
  \secdef\@part\@spart}

\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >-2\relax
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    \markboth{}{}%
    {\centering
     \interlinepenalty \@M
     \normalfont
     \ifnum \c@secnumdepth >-2\relax
       \huge\bfseries \partname\nobreakspace\thepart
       \par
       \vskip 20\p@
     \fi
     \Huge \bfseries #2\par}%
    \@endpart}

\def\@spart#1{%
    {\centering
     \interlinepenalty \@M
     \normalfont
     \Huge \bfseries #1\par}%
    \@endpart}

\def\@endpart{\vfil\newpage
              \if@twoside
               \if@openright
                \null
                \thispagestyle{empty}%
                \newpage
               \fi
              \fi
              \if@tempswa
                \twocolumn
              \fi}

\newlength\aboveptchapterskip
\newlength\belowptchapterskip
\setlength\aboveptchapterskip{-2.1\baselineskip}
\setlength\belowptchapterskip{2.5\baselineskip}

\newcommand\pretextualchapter{
  \if@openright\cleardoublepage\else\clearpage\fi
  \thispagestyle{empty}%
  \global\@topnum\z@
  \@afterindentfalse
  \@ptchapter}

\def\@ptchapter#1{
  \if@twocolumn
     \@topnewpage[\@makeptchapterhead{#1}]%
   \else
     \@makeptchapterhead{#1}%
     \@afterheading
   \fi}

\def\@makeptchapterhead#1{%
  \vspace*{\aboveptchapterskip}             % espaco antes do titulo
  {\parindent \z@ \normalfont % \raggedright % alinhado pela esquerda
    %\interlinepenalty\@M
    \center{\MakeUppercase{\textbf{#1}}}    % estilo do titulo
    \normalfont                             % estilo do texto apos o titulo
    \vskip \belowptchapterskip              % espaco apos o titulo
  }}

\newlength\abovechapterskip
\newlength\belowchapterskip
\setlength{\abovechapterskip}{-1.2\baselineskip}
\setlength{\belowchapterskip}{2.5\baselineskip}

\newcommand\chapter{
  \if@openright\cleardoublepage\else\clearpage\fi
  \thispagestyle{UERJ}%
  \global\@topnum\z@
  \@afterindentfalse
  \secdef\@chapter\@schapter}

\def\@chapter[#1]#2{
  \ifnum \c@secnumdepth >\m@ne
    \refstepcounter{chapter}\typeout{\@chapapp\space\thechapter.}%
      {
        \addcontentsline{toc}{chapter}
          {\normalfont\nobreak
            {\protect\numberline{\thechapter}}\nobreak
            {\bf\noexpand\uppercase{#1}}
          }
      }
  \else
    \addcontentsline{toc}{chapter}
      {\normalfont\nobreak
        {\protect\numberline{}}\nobreak
        {\noexpand\uppercase{#1}}
      }
  \fi
  \chaptermark{#1}%
  \if@twocolumn
    \@topnewpage[\@makechapterhead{#2}]%
  \else
    \@makechapterhead{#2}%
    \@afterheading
  \fi}

\def\@makechapterhead#1{%
  \vspace*{\abovechapterskip}                       % espaco antes do titulo
  {\parindent \z@ \raggedright \normalfont          % alinhado pela esquerda
    \ifnum \c@secnumdepth >\m@ne
      \textbf{\thechapter}\space\space              % estilo da numeracao do titulo
    \fi
    %\interlinepenalty\@M
    \MakeUppercase{\textbf{#1}}                     % estilo do titulo
    \normalfont                                     % estilo do texto apos o titulo
    \vskip \belowchapterskip                        % espaco apos o titulo
  }}

\def\@schapter#1{
  \phantomsection
  \addcontentsline{toc}{chapter}
    {\normalfont\protect\numberline{}\nobreak
      {\bf\uppercase{#1}}
    }
  \if@twocolumn
     \@topnewpage[\@makeschapterhead{#1}]%
   \else
     \@makeschapterhead{#1}%
     \@afterheading
   \fi}

\def\@makeschapterhead#1{%
  \vspace*{\abovechapterskip}                       % espaco antes do titulo
  {\parindent \z@ \raggedright \normalfont          % alinha pela esquerda
    %\interlinepenalty\@M
    \MakeUppercase{\textbf{#1}}                     % estilo do titulo
    \normalfont                                     % estilo do texto apos o titulo
    \vskip \belowchapterskip                        % espaco apos o titulo
  }}

\newcommand\postextualchapter{
  \if@openright\cleardoublepage\else\clearpage\fi
  \thispagestyle{UERJ}%
  \global\@topnum\z@
  \@afterindentfalse
  \secdef\@pstchapter\@spstchapter}

\def\@pstchapter[#1]#2{
  \ifnum \c@secnumdepth >\m@ne
    \refstepcounter{chapter}\typeout{\@chapapp\space\thechapter.}%
    \phantomsection\addcontentsline{toc}{chapter}
      {\normalfont\nobreak
        {\protect\numberline{}}\nobreak
        {\bf\uppercase{\@chapapp}\space\thechapter}\nobreak
        {\normalfont{\space\space--\space\space#1}}
      }
  \else
    \addcontentsline{toc}{chapter}
      {\normalfont\nobreak
        {\protect\numberline{}}\nobreak
        {\uppercase{#1}}
      }
  \fi
  \chaptermark{#1}%
  \if@twocolumn
    \@topnewpage[\@makepstchapterhead{#1}]%
  \else
    \@makepstchapterhead{#1}%
    \@afterheading
  \fi}

\def\@makepstchapterhead#1{%
  \vspace*{\abovechapterskip}                           % espaco antes do titulo
  {\parindent \z@ \raggedright \normalfont              % alinhado pela esquerda
    \MakeUppercase{\textbf{\@chapapp\space\thechapter}} % estilo da numeracao do titulo
    %\interlinepenalty\@M
    -- #1
    \normalfont                                         % estilo do texto apos o titulo
    \vskip \belowchapterskip                            % espaco apos o titulo
  }}

\def\@spstchapter#1{
  \phantomsection
  \addcontentsline{toc}{chapter}
    {\normalfont\protect\numberline{}\nobreak
      {\bf\uppercase{#1}}
    }
  \if@twocolumn
    \@topnewpage[\@makespstchapterhead{#1}]%
  \else
    \@makespstchapterhead{#1}%
    \@afterheading
  \fi}

\def\@makespstchapterhead#1{%
  \vspace*{\aboveptchapterskip}             % espaco antes do titulo
  {\parindent \z@ \normalfont  % \raggedright % alinhado pela esquerda
    %\interlinepenalty\@M
    \center{\MakeUppercase{\textbf{#1}}}    % estilo do titulo
    \normalfont                             % estilo do texto apos o titulo
    \vskip \belowptchapterskip              % espaco apos o titulo
  }}


\newboolean{appendixannex}
\setboolean{appendixannex}{false}


\newcommand\section{\@startsection {section}{1}{\z@}% #1 #2 #3
                                   {-2\baselineskip}% #4
                                   {\baselineskip}% #5
                                   {\protect\normalfont\protect\normalsize\bfseries}}%#6
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-2\baselineskip}%
                                     {\baselineskip}%
                                     {\protect\normalfont\protect\normalsize
                                      \noexpand\uline}}
\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-2\baselineskip}%
                                     {\baselineskip}%
                                     {\protect\normalfont\protect\normalsize}}

\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                     {-2\baselineskip}%
                                     {\baselineskip}%
                                     {\protect\normalfont\protect\normalsize}}
\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                     {-2\baselineskip}%
                                     {\baselineskip}%
                                     {\protect\normalfont\protect\normalsize}}

\newlength{\seclength}
\renewcommand{\@seccntformat}[1]{%\fbox
  {\csname the#1\endcsname}\space
}

\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \phantomsection
    \begingroup\relax
      \@hangfrom{\hskip #3\relax\@svsec}
      \interlinepenalty\@M
      \settowidth{\seclength}{\@seccntformat{#1}}
      \ifnum #2=2 %\fbox
        {\parbox[t]{\textwidth-\seclength-1em}
          {\raggedright#6\uline{#8}}} % solucao temporaria para \uline(?!?!)
      \else %\fbox
        {\parbox[t]{\textwidth-\seclength-1em}
          {\raggedright#6{#8}}}
      \fi
    \endgroup
    \ifthenelse{\boolean{appendixannex}}{}{
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth
        \else \protect\numberline{\csname the#1\endcsname}\fi#6{#7}}%
    }
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
          \@svsec {#8}
        }%
      \ifthenelse{\boolean{appendixannex}}{}{
        \addcontentsline{toc}{#1}{%
          \ifnum #2>\c@secnumdepth \else
            \protect\numberline{\csname the#1\endcsname}%
          \fi
          #7}
      }
    }%
  \fi
  \@xsect{#5}}


\newcommand\appendix{
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \setboolean{appendixannex}{true}
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}}

\newcommand\annex{
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \setboolean{appendixannex}{true}
  \gdef\@chapapp{\annexname}%
  \gdef\thechapter{\@Alph\c@chapter}}

\if@twocolumn
  \setlength\leftmargini  {2em}
\else
  \setlength\leftmargini  {2.5em}
\fi
\leftmargin  \leftmargini
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\if@twocolumn
  \setlength\leftmarginv  {.5em}
  \setlength\leftmarginvi {.5em}
\else
  \setlength\leftmarginv  {1em}
  \setlength\leftmarginvi {1em}
\fi
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}

\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}

\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}

\if@titlepage
  \newenvironment{abstract}{%
      \titlepage
      \null\vfil
      \@beginparpenalty\@lowpenalty
      \begin{center}%
        \bfseries \abstractname
        \@endparpenalty\@M
      \end{center}}%
     {\par\vfil\null\endtitlepage}
\else
  \newenvironment{abstract}{%
      \if@twocolumn
        \section*{\abstractname}%
      \else
        \small
        \begin{center}%
          {\bfseries \abstractname\vspace{-.5em}\vspace{\z@}}%
        \end{center}%
        \quotation
      \fi}
      {\if@twocolumn\else\endquotation\fi}
\fi

\newenvironment{verse}
               {\let\\\@centercr
                \list{}{\itemsep      \z@
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item\relax}
               {\endlist}

\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item\relax}
               {\endlist}

\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item\relax}
               {\endlist}

\if@compatibility
  \newenvironment{titlepage}
      {%
        \if@twocolumn
          \@restonecoltrue\onecolumn
        \else
          \@restonecolfalse\newpage
        \fi
        \thispagestyle{empty}%
        \setcounter{page}\z@
      }%
      {\if@restonecol\twocolumn \else \newpage \fi
      }
\else
  \newenvironment{titlepage}
      {%
        \if@twocolumn
          \@restonecoltrue\onecolumn
        \else
          \@restonecolfalse\newpage
        \fi
        \thispagestyle{empty}%
        \setcounter{page}\@ne
      }%
      {\if@restonecol\twocolumn \else \newpage \fi
       \if@twoside\else
          \setcounter{page}\@ne
       \fi
      }
\fi

\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}

\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}

\renewcommand\theequation {\@arabic\c@equation}

\newcounter{figure}
\renewcommand \thefigure {\@arabic\c@figure}

\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename\nobreakspace\thefigure}

\newenvironment{figure}
               {\@float{figure}}
               {\end@float}
\newenvironment{figure*}
                {\@dblfloat{figure}}
                {\end@dblfloat}

\newcounter{table}
\renewcommand \thetable {\@arabic\c@table}

\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename\nobreakspace\thetable}

\newenvironment{table}
               {\@float{table}}
               {\end@float}

\newenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}

\DeclareCaptionLabelSeparator{dash}{ - }

\DeclareCaptionTextFormat{capfmt}{#1}
\DeclareCaptionStyle{uerj}{
  format=hang,
  textformat=capfmt,
  labelsep=dash,
  justification=raggedright,
  singlelinecheck=false,
  font={small,onehalfspacing},
  position=top,
  skip=10pt % espaco entre caption e figura
}
\captionsetup{style=uerj}

\DeclareCaptionListFormat{figurefmt}{\figurename\hfill#2 - }
\captionsetup[figure]{listformat=figurefmt}

\DeclareCaptionListFormat{tablefmt}{\tablename\hfill#2 - }
\captionsetup[table]{listformat=tablefmt}

% \captionsetup[subfloat]{margin=1ex,
%                         position=bottom,
%                         nearskip=5pt, % mais espaco entre caption e figura
%                         farskip=5pt,  % espaco abaixo do subcaption
%                         captionskip=5pt}

\DeclareCaptionLabelFormat{legendfmt}{\legendname}
\DeclareCaptionStyle{legend}{
  format=hang,
  font={small,onehalfspacing},
  labelformat=legendfmt,
  labelsep=colon,
  justification=raggedright,
  position=bottom,
  aboveskip=12pt, % espaco acima da legenda
  singlelinecheck=false,
  list=no
}

\newcommand{\legend}[1]{
  \captionsetup{style=legend}
  % \@captype vem do pacote caption
  % traz o contador que esta sendo usado
  \addtocounter\@captype\m@ne\caption{#1}
}

\DeclareCaptionLabelFormat{sourcefmt}{\sourcename}
\DeclareCaptionStyle{source}{
  format=hang,
  labelformat=sourcefmt,
  labelsep=colon,
  position=bottom,
  aboveskip=0pt, % espaco acima da fonte
  justification=raggedright,
  singlelinecheck=false,
  font={small,onehalfspacing},
  list=no
}

\newcommand{\source}[1]{
  \captionsetup{style=source}
  % \@captype vem do pacote caption
  % traz o contador que esta sendo usado
  \addtocounter\@captype\m@ne\caption{#1}
}

\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em}
\newcommand\@dotsep{4.5}

\newcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \setlength\@tempdima{3em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \large \bfseries #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \fi}

\newcommand*\l@chapter{\@dottedtocline{0}{0em}{4.1em}}
\newcommand*\l@section{\@dottedtocline{1}{0em}{4.1em}}
\newcommand*\l@subsection{\@dottedtocline{2}{0em}{4.1em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{0em}{4.1em}}
\newcommand*\l@paragraph{\@dottedtocline{4}{0em}{5em}}
\newcommand*\l@subparagraph{\@dottedtocline{5}{0em}{6em}}
\newcommand*\l@figure{\@dottedtocline{0}{0em}{5.5em}}
\newcommand*\l@table{\@dottedtocline{0}{0em}{5.5em}}

\setcounter{tocdepth}{3}

\newcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \pretextualchapter{\contentsname}%
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    \cleardoublepage
    }

\newcommand\listoffigures{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \pretextualchapter{\listfigurename}%
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    }

\newcommand\listoftables{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \pretextualchapter{\listtablename}%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    }

\newdimen\bibindent
\setlength\bibindent{1.5em}

\newenvironment{thebibliography}[1] {
  \postextualchapter*{\bibname}%
  \list{\@biblabel{\@arabic\c@enumiv}}%
       {\settowidth\labelwidth{\@biblabel{#1}}%
        \leftmargin\labelwidth
        \advance\leftmargin\labelsep
        \@openbib@code
        \usecounter{enumiv}%
        \let\p@enumiv\@empty
        \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \sloppy
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m
}{
  \def\@noitemerr
  {\@latex@warning{Empty `thebibliography' environment}}%
  \endlist
}

\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty

\newenvironment{theindex}{
  \if@twocolumn
    \@restonecolfalse
  \else
    \@restonecoltrue
  \fi
  \twocolumn[\phantomsection \vskip -\abovechapterskip 
             \@makespstchapterhead{\indexname}]%
  \addcontentsline{toc}{chapter}
    {\normalfont\protect\numberline{}\nobreak
      {\bf\uppercase{\indexname}}
    }%
  \@mkboth{\MakeUppercase\indexname}{\MakeUppercase\indexname}%
  \thispagestyle{UERJ}\singlespacing
  \parindent\z@
  \parskip\z@ \@plus .3\p@\relax
  \columnseprule \z@
  \columnsep 35\p@
  \let\item\@idxitem
}
{
  \if@restonecol\onecolumn\else\clearpage\fi
}

\newcommand\@idxitem{\par\hangindent 40\p@}
\newcommand\subitem{\@idxitem \hspace*{20\p@}}
\newcommand\subsubitem{\@idxitem \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}

% espaco entre a ultima linha de texto e o traco da nota de rodape
\setlength{\skip\footins}{3\baselineskip}
\skip\@mpfootins = \skip\footins
\renewcommand\footnotesep{1.0\baselineskip}
\renewcommand\footnoterule{%
  \vspace*{0pt}
  \hrule\@width 10cm
  \vspace*{0pt}}
\newcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \makebox[0.8em][r]{\@makefnmark}\hspace{0.3em}\parbox[t]{\hsize-1.1em}{#1}}

% ------------------------------------------------------------------------
% ------------------------------------------------------------------------

% --- 
% Espacamentos entre linhas e paragrafos 
% --- 
% O tamanho do paragrafo eh dado por:
\setlength{\parindent}{1.25cm}
% --- 
% Controle do espacamento entre um paragrafo e outro:
\setlength{\parskip}{0cm}
% --- 
% Controle do espacamento entre paragrafos dentro de um item:
\setlength{\parsep}{0cm}
% --- 
% Controle do espacamento entre um item e outro:
\setlength{\itemsep}{0cm}
% --- 

% ------------------------------------------------------------------------
% ------------------------------------------------------------------------

\newcommand\contentsname{Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\bibname{Bibliography}
\newcommand\indexname{Index}
\newcommand\figurename{Figure}
\newcommand\legendname{Legend}
\newcommand\sourcename{Source}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\chaptername{Chapter}
\newcommand\appendixname{Appendix}
\newcommand\annexname{Annex}
\newcommand\abstractname{Abstract}

\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\pagestyle{plain}
\pagenumbering{arabic}
\if@twoside
\else
  \raggedbottom
\fi
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
\fi
\endinput
%%
%% End of file.
