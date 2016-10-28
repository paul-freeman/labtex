
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lablet}[2016/10/12 Lablet]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax
\LoadClass[plain,8pt,aspectratio=169,t]{beamer}

%\geometry{paperwidth=213mm,paperheight=120mm}

\newcommand{\labletheader}[1]{\textbf{#1} \\~\\}
\newcommand{\labletvideo}[2]{#2}
\newcommand{\labletcheck}[1]{$\Box$~#1 \\~\\}
\newcommand{\lablettext}[1]{#1 \\~\\}
\newenvironment{labletsheet}[1]
	{
	\begin{frame}[shrink]
	\frametitle{#1}
	}
	{
	\end{frame}
	}
\newenvironment{labletvideopage}[1]
	{
	\begin{frame}
	\frametitle{#1}
	}
	{
	\end{frame}
	}
\newcommand{\labletmotionpage}[3]
	{\begin{frame}
		\frametitle{#1}
		#3
		\begin{itemize}
			\item #2
		\end{itemize}
	\end{frame}}
\newcommand{\labletcalcyspeed}[3]
	{\begin{frame}
		\frametitle{#1}
		#3
		\begin{itemize}
			\item #2
		\end{itemize}
	\end{frame}}
\newcommand{\horizontaltwo}[2]
	{\begin{columns}[T]
		\begin{column}{0.48\textwidth}#1\end{column}
		\begin{column}{0.48\textwidth}#2\end{column}
	\end{columns}}
\newcommand{\horizontalthree}[3]
	{\begin{columns}[T]
		\begin{column}{0.32\textwidth}#1\end{column}
		\begin{column}{0.32\textwidth}#2\end{column}
		\begin{column}{0.32\textwidth}#3\end{column}
	\end{columns}}

\endinput

