# Minimal SQL Formatter

A simple VS Code extension for formatting SQL queries with minimal changes, tailored to match the style preferred by Paragon coworkers.

## Purpose

- Preserve original query style
- Apply only essential formatting adjustments
- Improve readability without altering intent

## Features

- Minimal whitespace normalization
- Consistent indentation
- No aggressive reformatting

## Installation

This extension is sideloaded via a `.vsix` file:

1. Download the `.vsix` file for Minimal SQL Formatter.
2. In VS Code, open the command palette (`Ctrl+Shift+P` or `Cmd+Shift+P`).
3. Run `Extensions: Install from VSIX...` and select the downloaded file.
4. Reload VS Code if prompted.

## Usage

- Open any `.sql` file in VS Code.
- Run the command `Minimal SQL Formatter: Format SQL` from the command palette, or use the context menu.

## Design Principles

- **Simplicity:** Focus on small, clear improvements
- **Readability:** Enhance clarity without changing query structure
- **Consistency:** Maintain familiar formatting conventions

## Implementation Notes

- Written in Python for easy customization
- Integrated into VS Code for quick formatting within your workflow

## License

Creative Commons