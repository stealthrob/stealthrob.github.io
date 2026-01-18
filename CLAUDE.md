# CLAUDE.md - Project Context for AI Assistants

## Project Overview
This is Roberto Nieto Salgado's personal tech blog and portfolio website, hosted on GitHub Pages.

## Tech Stack
- **Static Site Generator**: Jekyll
- **Theme**: Minima (customized)
- **Hosting**: GitHub Pages
- **Domain**: stealthrob.github.io

## Project Structure
```
├── _config.yml          # Jekyll configuration
├── _includes/           # Reusable HTML partials (head, header, footer, icons)
├── _layouts/            # Page templates (default, home, page, post)
├── _posts/              # Blog posts (Markdown)
├── _drafts/             # Unpublished drafts
├── _sass/               # SCSS stylesheets
├── _site/               # Generated site (don't edit directly)
├── assets/              # Static assets (CSS, images)
├── index.html           # Homepage
├── about.md             # About page
├── projects.md          # Projects page
├── contact.md           # Contact page
├── blog.html            # Blog listing page
└── favicon.svg          # Site favicon (RN initials)
```

## Key Files
- `_includes/head.html` - Contains meta tags, fonts, and favicon link
- `_config.yml` - Site title, description, social links, and build settings
- `assets/main.css` - Main stylesheet

## Styling
- Primary color: `#0366d6` (blue)
- Font: IBM Plex Mono (Google Fonts)
- Responsive design with mobile breakpoints at 600px

## Development Commands
```bash
# Install dependencies
bundle install

# Run local development server
bundle exec jekyll serve

# Build site
bundle exec jekyll build
```

## Notes
- The `_site` folder is auto-generated; edit source files instead
- Posts use YAML front matter with layout, title, date, and categories
- Social links configured in `_config.yml` (Twitter, GitHub, LinkedIn)
