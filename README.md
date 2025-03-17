# `latex-credits`: A LaTeX package for generating CRediT (Contributor Role Taxonomy) statements

This is a simple LaTeX package for generating contributor role
statements that can be easily included in a paper. The text of
the roles follows [CRediT](https://credit.niso.org/).

## Installation and Usage

Download [credits.sty](credits.sty) from this repository (or clone the
whole repository) and put it in your project. You may load the package
using `\usepackage{credits}`.

## Defining Authors

Use the `\credit` command to define an author and their contributions to
the paper. The `\credit` command takes two parameters, the first one
being the name of the author, the second one being a comma-separated
list of up to 14 roles that author a contributor might have.
These roles follow the CRediT scheme and are as follows:

1. Conceptualization
2. Data curation
3. Formal analysis
4. Funding acquisition
5. Investigation
6. Methodology
7. Project administration
8. Resources
9. Software
10. Supervision
11. Validation
12. Visualization
13. Writing -- original draft
14. Writing -- review & editing


Suppose your paper has three authors, you can enter roles as follows:
```latex
\credit{Alice}{Investigation, Methodology, Data curation, Writing -- original draft}
\credit{Bob}{Visualization,Conceptualization}
\credit{Charlie}{Software,Writing -- review \& editing,Validation}
```

NOTE: You may enter roles in an arbitrary order. Spelling is case sensitive.
Use `\` to escape the `&` character as in `Writing -- review \& editing`.

To add a statement about these contributions to the text, use the
`\insertcredits` command. The visualisation will be embedded in
a `tikzpicture` environment so it can be added in-place; it does not
make use of any floats. This is how the statement will look by default:

![Example contributor roles with default colours](assets/example_default.png)

There is also the option to generate a text statement about
contributors. Just use the `\insertcreditsstatement` command. Here is
how such a statement will be formatted (notice that author names have
been slightly changed):

![Example contributor text statement](assets/example_text_default.png)

## Example

The package is readily usable and permits some customisation (this
example can also be found in [example.tex](example.tex)):

```latex
\documentclass{article}

\usepackage{xcolor}

\definecolor{cardinal} {RGB}{196, 30, 58}
\definecolor{lightgrey}{RGB}{150,150,150}

% You can configure the colour of the grid and the respective roles of
% individual authors.
\usepackage[role = cardinal, grid = lightgrey]{credits}

% The CRediT taxonomy
% - Conceptualization
% - Data curation
% - Formal analysis
% - Funding acquisition
% - Investigation
% - Methodology
% - Project administration
% - Resources
% - Software
% - Supervision
% - Validation
% - Visualization
% - Writing -- original draft
% - Writing -- review \& editing


% Enter the roles for each author as a comma-separated list with
% exact spelling. Order can be arbitrary.
\credit{Alice}{Conceptualization, Methodology, Supervision, Project administration, Funding acquisition, Writing -- review \& editing}
\credit{Bob}{Supervision, Conceptualization, Funding acquisition, Methodology, Resources, Writing -- review \& editing}
\credit{Charlie}{Software, conceptualization, Formal analysis, Writing -- original draft, Writing -- review \& editing, Validation, Visualization}
\credit{Doug}{Investigation, Formal analysis, Data curation, Writing -- review \& editing, Supervision}
\credit{Eve}{Data curation, Investigation, Software, Writing -- original draft}
\credit{Frank}{Investigation, Data curation, Software, Formal analysis}
\credit{Grace}{Data curation, Writing -- original draft, Visualization}
\credit{Heidi}{Investigation, Data curation}
\credit{Ivan}{Software, Visualization, Writing -- original draft}
\credit{Judy}{Investigation}
% Note the typo in Charlie's role "conceptualization", which is lowercase
% and thus not accepted, instead showing a warning.

\begin{document}
% Display the credits statement as a table
\insertcredits
\end{document}
```

This results in the following output:

![Example contributor taxonomy with custom colours](assets/example_custom.png)

Partial contribution is also supported, see [example_granular.tex](example_granular.tex):
```latex
...
\definecolor{cvprblue}{rgb}{0.21,0.49,0.74}
\definecolor{lightgrey}{RGB}{150,150,150}
\usepackage[role = cvprblue, grid = lightgrey, skipempty, horizontal]{credits}

% You may enter roles with continous values indicating partial
% contribution. The ordering of the values follows the ordering
% of the original taxonomy, i.e.:
\credit{Doug}  {1,0.5,0,0,0.2,0.8,1,1,1,1,0.1,0,0.9,1}
\credit{Eve}    {0,1,0,1,0,1,0,1,0,1,0,1,0,1}
% Values between 0 and 1 will be scaled to be mixed with the background
% colour (white, unless changed by TikZ). This enables giving *partial*
% credit to authors (for instance, if someone helped out initially with
% data curation, but then later went on to another project).
\credit{Frank}{0,0.5,1,0,0,0,0,0,1,0,0,1,0,0}
```

![Example contributor taxonomy granular contributions](assets/example_granular.png)

By passing the boolean `horizontal` key when loading the package, you can switch
the ordering of rows and columns, essentially transposing the table.

```latex
\usepackage[horizontal]{credits}
```

Moreover, if some of the roles are empty (i.e., no contributor) and you want
to hide them, pass the boolean `skipempty` key:

```latex
\usepackage[skipempty]{credits}
```

When using `\insertcreditsstatement` the contributions are grouped by **role**.
If you want to group them by **author** instead, pass the boolean `byauthor` key:

```latex
\usepackage[byauthor]{credits}
...
\insertcreditsstatement
```

If you want to display two distinct statements in the same document:
```latex
... % use \credit to add first block of contributions
\insertcredits % Insert first statement
\resetcredits % Delete contributions
... % use \credit to add second block of contributions
\insertcredits % Insert second statement, this time a granular one
```

If you are only interested in the textual statement, you can use the
`separator` package option to slightly adjust its formatting.

```latex
% Default: separate individual concepts/roles by a semicolon. This seems
% to be the de facto standard endorsed by many publishers.
\usepackage[separator = {;}]{credits}

% This would create a list of contributions. Personally, I do not like
% this format too much.
\usepackage[separator = {\newline}]{credits}
```

Use `\insertcreditsstatement` to place your textual statement anywhere.
Similar to the visual statement, this environment does not create a new
group or float; it can be readily added to *any* text environment. You
can find the full example in [example_text.tex](example_text.tex).

## FAQ

To be more precise, this is a list of *anticipated* questions. No one
actually asked any of these questions.

1. *How can I contribute to this project?*\
   \
   Simple: open an issue or clone the repository and send me a pull
   request. All contributions are welcome!

2. *The LaTeX code is horrible!*\
   \
   Technically, this is not a question. Also: yes, agreed. Consider
   improving it by opening a pull request.

3. *Can you support a certain style or certain feature?*\
   \
   Maybe! Open an issue and let me know what you are interested in.

## Package Users

- [**Born et al.**, *Chemical representation learning for toxicity prediction*](https://pubs.rsc.org/en/content/articlelanding/2023/DD/D2DD00099G)

## License

The package is licensed using a BSD 3-Clause license. See [the license
file](LICENSE.md) for more information.
