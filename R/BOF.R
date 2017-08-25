#' @title Extract data from \href{http://www.cbooo.cn}{CBO}
#'
#' @description Extract data from \href{http://www.cbooo.cn}{CBO}
#'
#' @return a dataframe contain box office income from 2009
#' to 2017-7-31
#' @examples
#'
#' BOF()
BOF<-function(){
  income_by_year<-vector("list",10)
  base<-"http://www.cbooo.cn/year?year="
  for(i in seq_along(income_by_year)){
    url<-paste0(base,i+2007)
    html<-xml2::read_html(url,encode="UTF-8")
    table_content<-rvest::html_table(rvest::html_node(html,"table"))
    income_by_year[[i]]<-table_content
  }
  bof<-dplyr::bind_rows(income_by_year)
  bof
}
