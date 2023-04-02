\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{NBUTExam}[2022/05/13 v1.0 An exam class for USTB]

% 是否显示答案
\newif\ifanswer   \answertrue

\DeclareOption{noanswer}{\answerfalse}

%其它选项
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}

%不可省略
\ProcessOptions

% 四号	小四号	五号	  小五号
% 14bp	12bp	  10.5bp	9bp
\LoadClass[cs4size,UTF8,noindent,11pt]{ctexart}

\RequirePackage[a4paper,left=30mm,right=25mm,top=25mm,bottom=25mm]{geometry}
\RequirePackage{amsmath,amssymb}
\RequirePackage{multirow}
\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
\RequirePackage{comment}
% \RequirePackage{environ}
\RequirePackage{calc}
\RequirePackage{graphicx}
\RequirePackage{dashrule}
\RequirePackage{ifthen}
\RequirePackage{enumitem}
\RequirePackage{CJKnumb}
\RequirePackage{makecell}
\RequirePackage{tabularx}
\RequirePackage{interfaces-makecell}
\RequirePackage{tikz}
%\RequirePackage{hyperref}
% \RequirePackage{zref-lastpage}

\setlength{\parindent}{0em}
\setlength{\lineskiplimit}{3pt}
\setlength{\lineskip}{3pt}

\newcommand{\niandu}{}
\newcommand{\xueqi}{}
\newcommand{\kecheng}{}
\newcommand{\shijuan}{}
\newcommand{\qmz}{}
\newcommand{\duixiang}{}
\newcommand{\kstime}{}  

\newcommand{\underspace}[1]{\underline{\hspace{#1}}}

\newcommand{\fenyi}{}
\newcommand{\fener}{}
\newcommand{\fensan}{}
\newcommand{\fensi}{}
\newcommand{\fenwu}{}
\newcommand{\fenliu}{}
\newcommand{\fenqi}{}



\newcounter{TotalPart}
\newcounter{SubColumn}
\newcounter{EmptyColumn}

\setcounter{TotalPart}{1}



% 密封线

\newcommand{\mifengxian}
{
\begin{tikzpicture}[remember picture,overlay]
\path 	(current page.west) coordinate (a0);
\draw 	(a0)[shift={(1.0,0)}] node (a1) [rotate=90,fill=gray!0,minimum height=1cm,minimum width=1cm]
		{
		班级\raisebox{-2pt}{\rule{40mm}{0.4pt}}~~~~~~~~~~~~~~~%
		姓名\raisebox{-2pt}{\rule{40mm}{0.4pt}}~~~~~~~~~~~~~~~%
		学号\raisebox{-2pt}{\rule{40mm}{0.4pt}}}
		(a1)[shift={(1.0,0)}] node [rotate=90,fill=gray!0,minimum height=1cm,minimum width=1cm]
		{..............................................%
		\raisebox{-0.7ex}{装}.......................................................%
		\raisebox{-0.7ex}{订}.......................................................%
		\raisebox{-0.7ex}{线}......................................................};
\end{tikzpicture}
}

% 评分表
% 五道大题评分
\newcommand{\StableA}
{
\begin{tabular}{|c|c|c|c|c|c|c|c|}\hline
题号& 一 & 二 & 三 & 四 & 五 &总分 &复核人\\ \hline
应得分&~~~\fenyi~~~ &~~~\fener~~~ &~~~\fensan~~~ &~~~\fensi~~~ &~~~\fenwu~~~ &~~~100~~~ &\multirow{3}*{}\\ \cline{1-7}
实得分& & & & & & &\\ \cline{1-7}
评卷人& & & & & & &\\ \hline
\end{tabular}
}

% 六道大题评分
\newcommand{\StableB}
{
\begin{tabular}{|c|c|c|c|c|c|c|c|c|}\hline
题号& 一 & 二 & 三 & 四 & 五 & 六 &总分 &复核人\\ \hline
应得分&~~~\fenyi~~~ &~~~\fener~~~ &~~~\fensan~~~ &~~~\fensi~~~ &~~~\fenwu~~~&~~~\fenliu~~~ &~~~100~~~ &\multirow{3}*{}\\ \cline{1-8}
实得分& & & & & & & &\\ \cline{1-8}
评卷人& & & & & & & &\\ \hline
\end{tabular}
}

% 七道大题评分
\newcommand{\StableC}
{
\begin{tabular}{|c|c|c|c|c|c|c|c|c|c|}\hline
题号& 一 & 二 & 三 & 四 & 五 & 六 &七 &总分 &复核人\\ \hline
应得分&~~\fenyi~~ &~~\fener~~ &~~\fensan~~ &~~\fensi~~ &~~\fenwu~~&~~\fenliu~~& ~~\fenqi~~ &~~100~~ &\multirow{3}*{}\\ \cline{1-9}
实得分& & & & & & & & &\\ \cline{1-9}
评卷人& & & & & & & & &\\ \hline
\end{tabular}
}

\newcommand{\biaotou}
{
\begin{center}
		\parbox{\textwidth}{\centering {\Large \bfseries 宁波工程学院 {\niandu} 学年~~ 第~{\xueqi}~学期} \\
		\vspace{1em}
		{\Large \bfseries{\kecheng}课程{\qmz}试卷~~\shijuan }}
\end{center}
}

\newcommand{\jifenbiao}
{
\begin{center}
		\ifthenelse{\theTotalPart=5}{\StableA}{\ifthenelse{\theTotalPart=6}{\StableB}{\StableC}} \\
		\vspace{5pt}
		{\bfseries 适用班级：\duixiang~~~~~~~~~~~考试时间：\kstime 分钟}
\end{center}
}


% \newcommand{\my@foottext}{\kecheng 试卷 \quad 第~\thepage~页~共~\pageref{LastPage}~页}



%大题题号
\newcounter{problem}

\newcommand{\makepart}[2]{
	\setcounter{problem}{0}
	\stepcounter{section}
	{\large{\textbf{\Chinese{section}、#1}(#2)}}
	\vspace{0.5em}
}

%题型规则

\newcommand{\answer}[1]{
	\ifanswer{#1}\else\hphantom{#1}\fi
}

\newcommand{\fillin}[1]{
	\underline{\hspace{2em}\answer{#1}\hspace{2em}}
}

\newcommand{\pickout}[1]{
	\dotfill【\makebox[1.5em]{\answer{#1}}~】
}

\newcommand{\pickin}[1]{
	(\makebox[1.5em]{\answer{#1}})
}

\newcommand{\ignorepars}{\@ifnextchar\par{\expandafter\ignorepars\@gobble}{}}

\newenvironment{problemreal}{
	\stepcounter{problem}
	\arabic{problem}.\ignorespaces
}{\par}
\newenvironment{solutionreal}{\textsf{解}\quad\ignorepars}{\par}
\newenvironment{proofreal}{\textsf{证明}\quad\ignorepars}{\par}

\newenvironment{problem}{\problemreal}{\endproblemreal}
\newenvironment{solution}{\solutionreal}{\endsolutionreal}
\newenvironment{proof}{\proofreal}{\endproofreal}

\AtBeginDocument{
	\ifanswer\else
		\excludecomment{solution}
		\excludecomment{proof}
	\fi
}

\newlength{\xxla}
\newlength{\xxlb}
\newlength{\xxlc}
\newlength{\xxld}
\newlength{\lhalf}
\newlength{\lquarter}
\newlength{\lmax}

\newcommand{\options}[4]{
	\par
	\settowidth{\xxla}{【A】~#1~~~}
	\settowidth{\xxlb}{【B】~#2~~~}
	\settowidth{\xxlc}{【C】~#3~~~}
	\settowidth{\xxld}{【D】~#4~~~}

	\ifthenelse{\lengthtest{\xxla>\xxlb}}{\setlength{\lmax}{\xxla}}{\setlength{\lmax}{\xxlb}}
	\ifthenelse{\lengthtest{\xxlc>\lmax}}{\setlength{\lmax}{\xxlc}}{}
	\ifthenelse{\lengthtest{\xxld>\lmax}}{\setlength{\lmax}{\xxld}}{}
	\setlength{\lhalf}{0.5\linewidth}
	\setlength{\lquarter}{0.25\linewidth}
	\ifthenelse{\lengthtest{\lmax>\lhalf}}
	{
	\begin{enumerate}[label=【\Alph*】,parsep=0ex,itemsep=0ex,leftmargin=3em, topsep=0ex]
		\item #1
		\item #2
		\item #3
		\item #4
        \end{enumerate}
    }
    {
        \ifthenelse{\lengthtest{\lmax>\lquarter}}
        {
			\makebox[\lhalf][l]{【A】~#1~~~}%
			\makebox[\lhalf][l]{【B】~#2~~~}%

			\makebox[\lhalf][l]{【C】~#3~~~}%
			\makebox[\lhalf][l]{【D】~#4~~~}%
        }
        {
			\makebox[\lquarter][l]{【A】~#1~~~}%
			\makebox[\lquarter][l]{【B】~#2~~~}%
			\makebox[\lquarter][l]{【C】~#3~~~}%
			\makebox[\lquarter][l]{【D】~#4~~~}%
        }
    }
}