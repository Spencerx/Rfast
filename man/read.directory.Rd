\name{Reading the files of a directory}
\alias{read.examples}
\alias{read.directory}
\title{
Reading the files of a directory
}

\description{
Reading the files of a directory.
}

\usage{
read.examples(path.man,paths.full = FALSE)
read.directory(path.directory)
}

\arguments{
\item{path.man}{
The full path to the directory with the Rd files in it. 
For example: \"C:\\Users\\username\\Documents\\R\\Rfast_1.8.0\\man\\\"
}
\item{paths.full}{
Print or return the full paths.
}
\item{path.directory}{
The full path to the directory.
}
}

\details{
For function \"read.examples\":
Takes as an argument a full path to the directory of the Rd files. If you don't want the program to read any file add at the top of the file the attribute "\%[dont read]".
}

\value{
For function \"read.examples\": a list with 2 fields
\item{examples}{
A character vector with the examples of each Rd file.
}
\item{files}{
A character vector with the name of the file that each examples belongs.
}
\item{long_lines}{
A character vector with the name of the file that has large examples.
}

You can choose which files not to read for both R and Rd. You must add in the first line of the file in comment the "attribute" "\%[dont read]". Finally, that function wil return in the result a list of which files had this attribute.
}

%\references{
%}

\author{
R implementation and documentation: Manos Papadakis <papadakm95@gmail.com>.
}


\seealso{
\code{\link{AddToNamespace}, \link{sourceR}, \link{sourceRd}, \link{checkRd}, \link{checkExamples}
}
}

\examples{
# for example: path.man="C:\\some_file\\man\\"
# system.time( read.examples(path.man) )
# system.time( read.examples(path.man,dont.read=c("somef_1.Rd",...,"somef_n.Rd") ) )
}

\keyword{ Read directory }
\keyword{ Read Examples }