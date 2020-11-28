const initialDataScript = [
  'DELETE FROM Answer',
  'DELETE FROM Assessment',
  'DELETE FROM ChangeProject',
  'DELETE FROM NetworkCard',
  'DELETE FROM Note',
  'DELETE FROM Person',
  'DELETE FROM Question',
  'INSERT INTO Question (question_number, question) VALUES (\'2.1.1\',\'Was läuft richtig gut/was kannst Du richtig gut mit anderen Menschen?\')',
  'INSERT INTO Question (question_number, question) VALUES (\'2.1.2\',\'Was kannst/machst Du denn genau, worauf Du echt stolz sein kannst?\')',
  'INSERT INTO Question (question_number, question, subquestion) VALUES (\'2.1.3\',\'Zähle möglichst viele Deiner sozialen Fähigkeiten auf!\', \'Beschreibe so genau wie möglich, was Du machst/wie Du Dich verhältst.\')',
  'INSERT INTO Question (question_number, question, subquestion) VALUES (\'2.2.1\',\'Was fällt Dir manchmal schwer im Umgang mit anderen Menschen?\', \'Gibt es etwas, wo Du Dich über Dich selber ärgerst (oder schämst), das Du unbedingt besser hinkriegen möchtest? Zähle all die Situationen und Verhaltensweisen auf, wo Du gerne ein/e Andere/r wärst und notiere, wer Du wärst, und wie Du Dich verhalten würdest.\')',
  'INSERT INTO Question (question_number, question, subquestion) VALUES (\'2.2.2\',\'Wenn Du morgen früh aufwachst und im Umgang mit anderen so bist, wie Du es gerne hättest...\', \'Wie wärst Du dann? Wie würdest Du Dich dann verhalten?\')',
  'INSERT INTO Question (question_number, question, subquestion) VALUES (\'2.2.3\',\'Wenn Du daran denkst, was für eine Person Du gerne wärst...\', \'Wie könnte das Motto dieser Person lauten? (Z.B. «In meiner Clique habe immer alles im Griff» oder «Ich chille mein Leben» oder…?)\')',
  'INSERT INTO Question (question_number, question) VALUES (\'2.3.1\',\'Welches sind die beiden wichtigsten Situationen, die Du gerne anders hinkriegen möchtest?\')',
  'INSERT INTO Question (question_number, question, subquestion) VALUES (\'2.3.2\',\'Wenn Du jetzt nochmals über schwierige soziale Situationen (und auch über das Motto der Person, die Du gerne wärst!) nachdenkst...\', \'Welche Verhaltensweisen möchtest Du verändern? Welche neuen Verhaltensweisen wünscht Du Dir?\')',
  'INSERT INTO Question (question_number, question, subquestion) VALUES (\'2.4.1\',\'Was ganz konkret möchtest Du in den nächsten zwei bis drei Wochen ausprobieren?\', \'Beschreibe die neue Situation und auch das neue, andere Verhalten möglichst genau.\')',
  'INSERT INTO Question (question_number, question, subquestion) VALUES (\'2.6.1\',\'Wer der Jugendlichen könnte Dir dabei helfen?\', \'Wen willst Du einweihen und fragen, ob er/sie Dich unterstützt?\')',
  'INSERT INTO Question (question_number, question, subquestion) VALUES (\'2.6.2\',\'Die SozialpädagogInnen in der WG sind ja dazu da, Dich zu unterstützen\', \'Wen willst Du einbeziehen in Dein «Ja klar, das schaff ich-»-Projekt/Vorhaben?\')',
  'INSERT INTO Question (question_number, question) VALUES (\'2.6.3\',\'Hast Du sonst noch eine Idee, wer oder was Dir bei Deinem Projekt behilflich sein könnte?\')',
  'INSERT INTO Question (question_number, question) VALUES (\'3.2.1\',\'Ein Gespräch anfangen/andere ansprechen\')',
  'INSERT INTO Question (question_number, question) VALUES (\'3.2.2\',\'In einer mir bekannten Gruppe etwas sagen/eine Idee vorbringen\')',
  'INSERT INTO Question (question_number, question) VALUES (\'3.2.3\',\'In einer mir unbekannten Gruppe etwas sagen/eine Idee vorbringen\')',
  'INSERT INTO Question (question_number, question) VALUES (\'3.2.4\',\'Etwas Lustiges sagen oder machen, andere zum Lachen bringen\')',
  'INSERT INTO Question (question_number, question) VALUES (\'3.2.5\',\'Jemanden anlächeln/einen Blick zuwerfen\')',
  'INSERT INTO Question (question_number, question) VALUES (\'3.2.6\',\'Jemanden neugierig machen/Interesse wecken\')',
  'INSERT INTO Question (question_number, question) VALUES (\'3.3.1\',\'Jemanden nach dem Befinden fragen\')',
  'INSERT INTO Question (question_number, question) VALUES (\'3.3.2\',\'Jemandem etwas Freundliches sagen/ein Kompliment machen\')',
  'INSERT INTO Question (question_number, question) VALUES (\'3.3.3\',\'gut zuhören\')',
  'INSERT INTO Question (question_number, question) VALUES (\'3.3.4\',\'Jemandem etwas Wichtiges anvertrauen\')',
  'INSERT INTO Question (question_number, question) VALUES (\'3.3.5\',\'Gemeinsam lachen\')',
  'INSERT INTO Question (question_number, question) VALUES (\'3.3.6\',\'Auf eine Frage/ein Anliegen eingehen\')',
  'INSERT INTO Question (question_number, question) VALUES (\'3.3.7\',\'Eigene Irritationen/Schwierigkeiten ansprechen\')',
  'INSERT INTO Question (question_number, question) VALUES (\'3.4.1\',\'Freude über die Beziehung/das Gespräch zeigen\')',
  'INSERT INTO Question (question_number, question) VALUES (\'3.4.2\',\'Ansprechen, wie es weitergeht\')',
  'INSERT INTO Question (question_number, question, subquestion) VALUES (\'3.4.3\',\'-	jemandem ein Feedback geben \', \'(z.B. was ich toll fand, was schwierig war)\')',
  'INSERT INTO Question (question_number, question) VALUES (\'3.4.4\',\'Weitere Fragen formulieren\')',
  'INSERT INTO Question (question_number, question) VALUES (\'3.4.5\',\'Um ein weiteres Gespräch bitten\')',
  'INSERT INTO Question (question_number, question, subquestion) VALUES (\'3.4.6\',\'Weitere Gesprächsmöglichkeiten ansprechen \', \'(z.B. ich hätte nächste Woche wieder Zeit)\')',
];