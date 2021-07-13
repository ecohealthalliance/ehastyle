# ehastyle

R Markdown templates for EcoHealth Alliance presentations, dashboards, and reports. 
## Why use rmarkdown and templates?

The biggest advantage of rmarkdown is that it allows you to dynamically generate
content. That means plots, tables, text, etc will change as your code or data change. For example, you are working on a presentation for a conference and continually refining the plots. If you build your presentation in rmarkdown
then export to powerpoint (ppt), you won't have to worry about having the most
up-to-date plot or have to deal with managing a folder full of presentation_plot_final_final.png type files. Your plots will be stored in your
presentation and update along with your code and data. 

The next super power using rmarkdown gives you is reproducibility. Because your code and content are stored in a single .rmd file, it is easy to track exactly how a figure is being generated and to share the file with collaborators. If you track
your file with version control ([GIT](https://happygitwithr.com/)), then you will also be able to see how your document has changed through time and who has made those changes. 

By using templates, we can produce consistently styled content across the organization with minimal effort. As style guides change, we can update the templates and retroactively change the styling of content with a single line of 
code. 

![xckd automation](https://xkcd.com/1205/)

## How to use rmarkdown templates

See [R Markdown: The Definitive Guide](https://bookdown.org/yihui/rmarkdown/document-templates.html) and [Markdown Cookbook](https://bookdown.org/yihui/rmarkdown-cookbook/package-template.html) for more information. 

## Slide presentations

This package contains `classic`, `avenir`, and `predict` presentation templates that can be used with an aspect ratio of `16x9` or `4x3`. 

### PPTX

### Xaringan

## Dashboards

### Flexdashboard

## Documents

### Word



