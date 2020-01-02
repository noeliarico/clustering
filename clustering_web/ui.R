# k-means only works with numerical variables,
# so don't give the user the option to select
# a categorical variable
vars <- setdiff(names(iris), "Species")

navbarPage(
  "Navbar!",
  tabPanel(
    "Plot",
    headerPanel('Iris k-means clustering'),
    sidebarLayout(
      sidebarPanel(
        selectInput('xcol', 'X Variable', vars),
        selectInput('ycol', 'Y Variable', vars, selected = vars[[2]]),
        numericInput('clusters', 'Cluster count', 3, min = 1, max = 9)
        
      ),
      mainPanel(plotOutput('plot1'))
    )
  ),
  tabPanel(
    "Noelia",
    headerPanel('Data exploration: principal components analysis'),
    
    sidebarLayout(
      sidebarPanel(
        selectInput('data_name_input', 'Dataset:', names(datasets))
      ),
      mainPanel(
        h2("Info"),
        plotOutput('data_pca'),
        DT::dataTableOutput("data_info")
      )
    )
  )
)