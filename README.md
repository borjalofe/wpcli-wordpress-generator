# WPCLI WordPress Generator

This repo aims at ease you build your own WP-CLI-based WordPress Generator Script. Hope it helps

## How To Use It -in a nutshell-

## Table of Contents

- [WPCLI WordPress Generator](#wpcli-wordpress-generator)
  - [How To Use It -in a nutshell-](#how-to-use-it--in-a-nutshell-)
  - [Table of Contents](#table-of-contents)
  - [Intro](#intro)
  - [How it works](#how-it-works)
    - [Code Structure](#code-structure)
    - [Helper Functions](#helper-functions)
      - [generate_db_prefix](#generate_db_prefix)
        - [generate_db_prefix usage](#generate_db_prefix-usage)
      - [generate_pass](#generate_pass)
        - [generate_pass usage](#generate_pass-usage)
      - [get_domain](#get_domain)
        - [get_domain usage](#get_domain-usage)
      - [slugify](#slugify)
        - [slugify usage](#slugify-usage)
  - [How to modify this project](#how-to-modify-this-project)
    - [Features](#features)
      - [Question: How can I add a new menu?](#question-how-can-i-add-a-new-menu)
      - [Question: How can I add a new page?](#question-how-can-i-add-a-new-page)
      - [Question: How can I add a new plugin?](#question-how-can-i-add-a-new-plugin)
      - [Question: How can I add a new paid plugin?](#question-how-can-i-add-a-new-paid-plugin)
      - [Question: How can I add a new widget?](#question-how-can-i-add-a-new-widget)
    - [Themes](#themes)
      - [Question: How can I add a new theme?](#question-how-can-i-add-a-new-theme)
      - [Question: How can I add a new paid theme?](#question-how-can-i-add-a-new-paid-theme)
    - [Wanna know anything more?](#wanna-know-anything-more)
  - [Technologies](#technologies)
  - [Sources](#sources)
  - [Status](#status)

## Intro

If you've build several websites using WordPress, you'd know by now most of those projects are -basically- the same project. You just need to change contents, colors and images.

So... you're doing the same actions everytime you build a website:

1. Install&Setup WordPress
2. Install&Setup a WordPress Theme
3. Install&Setup Features -which fall into one of the following three categories-:
   1. Common-to-all-projects Features:
      1. Plugins: Forms Plugin, Cookies Plugin -at least in Europe-, WPO Plugin -e.g. WP Rocket-, ...
      2. Pages: homepage, blog page, contact page, legal pages -legal notice, privacy policy, cookies policy, ...
      3. Menus: main menu -usually a the top of the page-, footer / legal menu, ...
   2. Common-to-a-project-category Features:
      1. eCommerce: e.g. WooCommerce -plugin-, utc page, profile page, account menu, ...
      2. membership site: e.g. MemberPress -plugin-, profile page, account menu, ...
      3. educational: e.g. LearnDash, courses page, subject page, profile page, account menu, ...
   3. Project-specific Features:
      1. any plugin you need for a specific feature, e.g. Flamingo -to save all Contact Form 7 submits in the WordPress database,...
      2. any page: e.g. team page, ...
4. Project-specific customizations -made in the `functions.php` file.

You can see you are repeating from point 1 to point 3.2.1 for each and every project you build. How much time -and money- does it cost to you? On average, that part of the setup takes 2 to 4 hours.

And what about point 3.2.2. -which you're doing every time you build a category-specific project?

Wouldn't it be great if you could automate all that work and focus on what truly adds value to a project?

I hope this repo helps you to write a script that automates anything common to your projects. I made it as generic as possible so you have a good base to begin with and I'm trying to add as much info as I can so you can modify it to build your own customized script.

Feel free to contact me to ask for help. I won't answer for theme or plugin specific setups -too many themes and plugins out there- but I'm open to help with anything else -e.g. how can you get info about plugins, pages, ... to make your own modifications-.

Just make sure you read the [How to modify this project](#how-to-modify-this-project) section before as any question I've been asked is answered there.

## How it works

### Code Structure

```mermaid
    flowchart TB
        subgraph base [Base Install]
            direction LR
            C --> D[Base Install]
            D --> E[User Setup]
            E --> F[Theme Setup]
            F --> G{Is it a paid theme?}
            G -->|yes| H[Install Paid Theme Plugin]
        end
        subgraph content [Content Setup]
            direction LR
            G ---->|No| I[Home Page Setup]
            H --> I
            I --> J[Blog Page Setup]
            J --> K[Contact Page Setup]
            K --> L{Is Contact Form 7 installed?}
            L -->|No| M[Contact Form 7 Install & Setup]
            L ---->|Yes| N[Create & Add Contact Form to Contact Page]
            M --> N
            N --> O{Has the web being flagged as eCommerce?}
            O -->|Yes| P[WooCommerce Install & Setup]
        end
        subgraph content [Ending Tasks]
            direction LR
            O ---->|No| Q[Update Website]
            P --> Q
            Q --> R[Clean Installation Files]
        end
        A[Helper Functions]
        B[Set Defaults] --> C[Get User Input]
        R --> S((Finish!))
```

### Helper Functions

#### generate_db_prefix

`generate_db_prefix` has all the code needed to generate a secure DB_PREFIX. Though it's only used once in every project, I thought it will be easier to improve and maintain the code by being in a function.

The function provides 2 ways to generate a DB_PREFIX:

1. A completetly random DB_PREFIX,
2. A seed-based DB_PREFIX

##### generate_db_prefix usage

Without seed:

`DB_PREFIX=$(generate_db_prefix)`

With seed:

`DB_PREFIX=$(generate_db_prefix $SEED)`

#### generate_pass

`generate_pass` has all the code needed to generate a secure password. Though it's only used once in every project, I thought it will be easier to improve and maintain the code by being in a function.

**As the code of this function it's been published as an example, you MUST change it to match your needs.**

##### generate_pass usage

`PASSWORD=$(generate_pass $SEED)`

#### get_domain

For me, the DOMAIN it's the real project name and matches the first part of the website's url -which is the domain without the TLD or the subdomain if the URL has one.

`get_domain` has all the code needed to get the domain from the URL. We're going to use several times during the installation.

##### get_domain usage

`DOMAIN=$(get_domain $URL)`

#### slugify

WordPress uses both regular names and slugs to identify several objects -such as users or pages-. Generally, the same creation process of this objects handle the needed slugificacion.

For those cases we need to handle ourselves, I've written this function.

##### slugify usage

`SLUG=$(slugify ${THE_NAME_TO_BE_SLUGIFIED// /})`

Please, note we substitute spaces before passing THE_NAME_TO_BE_SLUGIFIED so the function has no problem getting all the name as one parameter.

## How to modify this project

### Features

#### Question: How can I add a new menu?

#### Question: How can I add a new page?

#### Question: How can I add a new plugin?

#### Question: How can I add a new paid plugin?

#### Question: How can I add a new widget?

### Themes

#### Question: How can I add a new theme?

#### Question: How can I add a new paid theme?

### Wanna know anything more?

I'm no to going to answer questions about specific setups -such as "how can I setup plugin X?"- as this repo it's not aimed at giving customized solutions but to encourage you to create your own.

On the other hand, I'll try to anwser any question it's not already answered in this section.

## Technologies

WPCLI WordPress Generator has been developed with:

- Shellscript
- [WP CLI][wpcli]

## Sources

## Status

This project has been tested up to WordPress 6 and PHP 8.

Created by [@borjalofe][github].

[github]: https://github.com/borjalofe/
[wpcli]: https://make.wordpress.org/cli/
