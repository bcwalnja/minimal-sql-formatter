import * as vscode from 'vscode';

export function activate(context: vscode.ExtensionContext) {
    //#region SQL Keywords
    const keywords = {
        clauses: [
            'select', 'from', 'where', 'group by', 'having', 'order by'
        ],
        joins: [
            'inner join', 'left join', 'right join', 'full join', 'cross join'
        ],
        conditions: [
            'on', 'and', 'or', 'not', 'in', 'is', 'null', 'like'
        ],
        statements: [
            'declare', 'insert into', 'values', 'update', 'set', 'delete',
            'create table', 'alter table', 'drop table',
            'create index', 'drop index'
        ],
        controlFlow: [
            'if exists', 'case', 'when', 'then', 'else', 'end'
        ],
        modifiers: [
            'as'
        ],
        unions: [
            'union', 'union all'
        ]
    };

    // all keywords: getter that concats the arrays
    const allKeywords: string[] = [];
    Object.values(keywords).forEach(element => {
        allKeywords.push(...element);
    });
    //#endregion


    let disposable = vscode.commands.registerCommand('minimalSqlFormatter.format', () => {
        //#region Formatting functions
        function minimumOneNewline(sql: string): string {
            let formatted = sql;
            for (const keyword of keywords.clauses) {
                // get all characters that come between the keyword and the previous non-whitespace character
                // only make edits if there are no newlines in that space
                const regex = new RegExp(`([^\s]{2}) {0,}(${keyword})`, 'gi');
                formatted = formatted.replace(regex, (match, p1, p2) => {
                    if (p1.includes('\n') || p1.includes('--')) {
                        return match; // already has a newline or is a comment
                    } else {
                        return p1 + '\n    ' + p2; // add a newline
                    }
                });
            }

            return formatted;
        }

        function lowercaseKeywords(sql: string): string {
            let formatted = sql;
            for (const keyword of allKeywords) {
                // search using word boundaries to avoid partial matches
                const regex = new RegExp(`\\b${keyword}\\b`, 'gi');
                formatted = formatted.replace(regex, (match) => {
                    return match.toLowerCase();
                });
            }
            return formatted;
        }

        function fixCommas(sql: string): string {
            // Replace any amount of whitespace before and after a comma with ','
            // unless the space is at the start of the line
            // Step 1: Remove leading spaces before comma (unless at start of line)
            sql = sql.replace(/(\S)\s+,/g, '$1,');
            // Step 2: Remove trailing spaces after comma
            sql = sql.replace(/,\s+/g, ',');
            return sql;
        }

        /*
        function oneLineClauses(sql: string): string {
            const majorKeywords = [
                'select', 'from', 'where', 'group by', 'having', 'order by',
                'inner join', 'left join', 'right join', 'full join', 'cross join',
                //'on', 'and', 'or', 'not', 'in', 'is', 'null', 'like',
                'declare', 'insert into', 'values', 'update', 'set', 'delete',
                'create table', 'alter table', 'drop table',
                'create index', 'drop index',
                'if exists', 'case', 'when', 'then', 'else', 'end',
                'union', 'union all'
            ];

            function containsKeyword(line: string): boolean {
                return majorKeywords.some(k =>
                    new RegExp(`\\b${k}\\b`, 'i').test(line)
                );
            }

            let lines = sql.split(/\r?\n/);
            for (let i = lines.length - 2; i >= 0; i--) {
                const line1 = lines[i];
                const line2 = lines[i + 1];
                if (line1.trim() && line2.trim() &&
                    !containsKeyword(line1) &&
                    !containsKeyword(line2)) {
                    lines[i] = line1.replace(/\s+$/, '') + ' ' + line2.replace(/^\s+/, '');
                    lines.splice(i + 1, 1);
                }
            }
            return lines.join('\n');
        }
        */
        //#endregion

        const editor = vscode.window.activeTextEditor;
        if (!editor) { return; }
        if (editor.document.languageId !== 'sql') { return; }
        const selection = editor.selection;
        const hasSelection = !selection.isEmpty;
        const text = hasSelection
            ? editor.document.getText(selection)
            : editor.document.getText();
        const range = hasSelection
            ? selection
            : new vscode.Range(
                editor.document.positionAt(0), editor.document.positionAt(text.length)
            );
        let formatted = minimumOneNewline(text);
        formatted = lowercaseKeywords(formatted);
        formatted = fixCommas(formatted);
        editor.edit(editBuilder => {
            editBuilder.replace(range, formatted);
        });
    });
    context.subscriptions.push(disposable);
}
export function deactivate() { }
