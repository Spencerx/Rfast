
#[export]
as.Rfast.function<-function(Rfunction.name,margin=NULL){
    Rffunc<-NULL
    details<-0
    margin.is.true<-!is.null(margin)
    
    if(Rfunction.name=="all"){
        Rffunc<-"All"
        details<-3
    }
    else if(Rfunction.name=="any"){
        Rffunc<-"Any"
        details<-3
    }
    else if(Rfunction.name=="diff"){
        Rffunc<-"diffs"
        details<-2
    }
    else if(Rfunction.name=="hamean"){
        Rffunc<-"hameans"
        details<-3
    }
    else if(Rfunction.name=="mad"){
        Rffunc<-if(margin.is.true) "Mads" else "Mad"
        details<-4
    }
    else if(Rfunction.name=="max"){
        Rffunc<-"Maxs"
        details<-3
    }
    else if(Rfunction.name=="means" || Rfunction.name=="colMeans" || Rfunction.name=="rowMeans"){
        Rffunc<-"means"
        details<-3
    }
    else if(Rfunction.name=="median"){
        Rffunc<-if(margin.is.true) "Medians" else "Median"
        details<-4
    }
    else if(Rfunction.name=="min"){
        Rffunc<-"Mins"
        details<-3
    }
    else if(Rfunction.name=="order"){
        Rffunc<-"Order"
        details<-4
    }
    else if(Rfunction.name=="pmax"){
        Rffunc<-"Pmax"
        details<-4
    }
    else if(Rfunction.name=="pmin"){
        Rffunc<-"Pmin"
        details<-4
    }
    else if(Rfunction.name=="prod"){
        Rffunc<-"prods"
        details<-3
    }
    else if(Rfunction.name=="range"){
        Rffunc<-"range"
        details<-3
    }
    else if(Rfunction.name=="rank"){
        Rffunc<-if(margin.is.true) "Ranks" else "Rank"
        details<-4
    }
    else if(Rfunction.name=="sample"){
        Rffunc<-"Shuffle"
        details<-3
    }
    else if(Rfunction.name=="sum" || Rfunction.name=="colSums" || Rfunction.name=="rowSums"){
        Rffunc<-"sums"
        details<-3
    }
    else if(Rfunction.name=="tabulate"){
        Rffunc<-"Tabulate"
        details<-3
    }else if(Rfunction.name=="sort"){
        Rffunc<-"Sort"
        details<-4
    }else if(Rfunction.name=="var"){
        Rffunc<-if(margin.is.true) "Vars" else "Var"
        details<-4
    }else if(Rfunction.name=="rowsum"){
        Rffunc<-"group"
    }else if(Rfunction.name=="lower.tri"){
        Rffunc<-"lower_tri"
    }else if(Rfunction.name=="upper.tri"){
        Rffunc<-"upper_tri"
    }else if(Rfunction.name=="chol"){
        Rffunc<-"cholesky"
    }else if(Rfunction.name=="choose"){
        Rffunc<-"Choose"
    }else if(Rfunction.name=="log"){
        Rffunc<-"Log"
    }else if(Rfunction.name=="lbeta"){
        Rffunc<-"Lbeta"
    }else if(Rfunction.name=="lgamma"){
        Rffunc<-"Lgamma"
    }else if(Rfunction.name=="lchoose"){
        Rffunc<-"Lchoose"
    }else if(Rfunction.name=="trigamma"){
        Rffunc<-"Trigamma"
    }else if(Rfunction.name=="combn"){
        Rffunc<-"comb_n"
    }else if(Rfunction.name=="as.data.frame.matrix"){
        Rffunc<-"data.frame.to_matrix"
    }else if(Rfunction.name=="model.matrix"){
        Rffunc<-"design_matrix"
    }else if(Rfunction.name=="digamma"){
        Rffunc<-"Digamma"
    }else if(Rfunction.name=="is.element"){
        Rffunc<-"is_element"
    }else if(Rfunction.name=="mahalanobis"){
        Rffunc<-"mahala"
    }else if(Rfunction.name=="t"){
        Rffunc<-"transpose"
    }else if(Rfunction.name=="as.numeric"){
        Rffunc<-"as_integer"
    }else if(Rfunction.name=="match"){
        Rffunc<-"Match"
    }else if(Rfunction.name=="norm"){
        Rffunc<-"Norm"
    }else if(Rfunction.name=="table"){
        Rffunc<-"Table"
    }else{
        stop("Error: unsupported function from Rfast.")
    }

    if(details==0 && margin.is.true){
        stop("Error: this function is not supported column-row method.")
    }else if(details>0 && details!=4 && !margin.is.true){
        stop("Error: this function is supported only for column-row method.")
    }else if(details==1 && margin==2){
        stop("Error: this function is supported only for row method.")
    }else if(details==2 && margin==1){
        stop("Error: this function is supported only for col method.")
    }
    
    if(details>0 && margin.is.true){
        Rffunc<-sprintf("%s%s",if(margin==1) "row" else "col",Rffunc)
    }
    eval(parse(text=sprintf("Rfast::%s",Rffunc)))
}

#[export]
AddToNamespace <- function(path.namespace,path.rfolder,paths.full = FALSE) {
  .Call(Rfast_add_to_namespace,path.namespace,path.rfolder,paths.full)
}

#[export]
RemoveFromNamespace <- function(path.namespace,files.to.remove) {
  .Call(Rfast_remove_from_namespace,path.namespace,files.to.remove)
}

#[export]
read.directory <- function(path.directory) {
  .Deprecated("This function will be permanently removed.")
}

#[export]
read.examples<-function(path.man,paths.full = FALSE){
  .Call(Rfast_read_examples,path.man,paths.full)
}

#[export]
checkTF <- function(path.man,paths.full = FALSE) {
	.Call(Rfast_check_true_false,path.man,paths.full)
}

#[export]
checkNamespace <- function(path.namespace,path.rfolder,paths.full = FALSE) {
	.Call(Rfast_check_namespace,path.namespace,path.rfolder,paths.full)
}

#[export]
checkExamples<-function(path.man,package,each = 1,print.errors = stderr(),print.names = FALSE,paths.full = FALSE){
    examples_files <- .Call("Rfast_read_examples", PACKAGE="Rfast",path.man,paths.full = FALSE)
    packageEnv <- new.env(parent = getNamespace(package))
    error_files<-vector("character")
    examples <- examples_files$examples
    file_names<-examples_files$files

    max_file_name <- max(nchar(file_names))

    if(!is.null(print.errors)){
        warning_error_function <-function(err){
            error_files <<- c(error_files,file_names[i])
            return (err)
        }
    }else{
        warning_error_function <-function(err){
            error_files <<- c(error_files,file_names[i])
            return (err)
        }
    }
    
    getTime<-function(time){
        time<-unclass(time)
        tim<- round(time[1], 2)
        s <- ""
        if(tim == 0){
            s<-"<"
        }
        paste(s,tim," ",attr(time,"units"), sep="")
    }
    if(print.names){
        for(i in 1:length(examples)){
            spaces <- strrep(" ", max_file_name - nchar(file_names[i])) #how many space should i  place in order to have vertical orientation
            cat("\033[1;34m",file_names[i],"\033[0m", spaces)
            err <- NULL
            t <-0
            for(j in 1:each){
                st <- Sys.time()
                err <- tryCatch(eval(parse(text=examples[i]),envir=packageEnv),error=warning_error_function, warning=warning_error_function)
                et <- Sys.time()
                t <- t + et - st
                found_error <- inherits(err, "error") || inherits(err, "warning")
                if (found_error) {
                    break
                }
            }
            cat(" \033[32m(", getTime(t/each), ")\033[0m\n", sep="")
            if(found_error){
                cat("\t\033[31mError/Warning: ", gsub("\n", "\n\t", conditionMessage(err)), "\033[0m\n")  # Display error or warning in red
            }
        }
    }else{
        for(i in 1:length(examples)){
            for(j in 1:each){
                tryCatch(eval(parse(text=examples[i]),envir=packageEnv),error=warning_error_function, warning=warning_error_function)
            }
        }
    }
    list("Errors"=error_files,"Big Examples"=examples_files$long_lines,"dont read"=examples_files$`dont read`)
}

#[export]
checkAliases <- function(path.man,path.rfolder,paths.full = FALSE) {
	.Call(Rfast_check_aliases,path.man,path.rfolder,paths.full)
}

#[export]
checkUsage <- function(path.man,path.rfolder,paths.full = FALSE) {
	.Call(Rfast_check_usage,path.man,path.rfolder,paths.full)
}

#[export]
sourceR <- function(path,local=FALSE,encode = "UTF-8",print.errors=FALSE) {
  file_names <- list.files(path)
  error_files<-vector("character")
  if(print.errors){
    warning_error_function <-function(err){
      write(paste(file_names[i],":","\n",err),stderr())
      error_files <<- c(error_files,file_names[i])
    }
  }else{
    warning_error_function <-function(err){
      error_files <<- c(error_files,file_names[i])
    }
  }
  for(i in 1:length(file_names)){
    tryCatch(source(sprintf("%s%s",path,file_names[i]),local = local, encoding = encode),
             error=warning_error_function, warning=warning_error_function)
  }
  if(length(error_files)==0){
    return("Everything is ok..!")
  }
  error_files
}

#[export]
sourceRd <- function(path,print.errors=FALSE, macros = NULL) {
  file_names <- list.files(path, pattern = "*.Rd")
  error_files<-vector("character")
  if(print.errors){
      warning_error_function <-function(err){
          write(paste(file_names[i],":","\n",err),stderr())
          error_files <<- c(error_files,file_names[i])
      }
  }else{
      warning_error_function <-function(err){
          error_files <<- c(error_files,file_names[i])
      }
  }
  error<-0
  for(i in 1:length(file_names)){
      error<-tools::checkRd(sprintf("%s%s",path,file_names[i]), macros = macros)
      if(length(error)!=0){
          warning_error_function(error)
      }
  }
  if(length(error_files)==0){
      return("Everything is ok..!")
  }
  return(error_files)
}