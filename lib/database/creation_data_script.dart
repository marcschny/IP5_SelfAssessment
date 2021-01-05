//only modify this file if a new question has to be inserted
//if a question or subquestion has to be changed, modify the file 'update_data_script.dart'
//otherwise DO NOT modify this file
const creationDataScript = [
  'DELETE FROM Answer',
  'DELETE FROM Assessment',
  'DELETE FROM Experience',
  'DELETE FROM Visualization',
  'DELETE FROM Person',
  'DELETE FROM Question',
  'INSERT INTO Question (question_number, question, subquestion)  VALUES (\'2.1.1\',\'Was kannst Du richtig gut im Umgang mit anderen Menschen?\', \'Zähle möglichst viel auf.\')',
  'INSERT INTO Question (question_number, question)               VALUES (\'2.2.1\',\'Was fällt Dir manchmal schwer im Umgang mit anderen Menschen?\')',
  'INSERT INTO Question (question_number, question)               VALUES (\'2.3.1\',\'Was möchtest Du in den nächsten Wochen ausprobieren?\')',
  'INSERT INTO Question (question_number, question, subquestion)  VALUES (\'2.5.1\',\'Wer der Jugendlichen könnte Dir dabei helfen?\', \'Wen willst Du einweihen und fragen, ob er/sie Dich unterstützt?\')',
  'INSERT INTO Question (question_number, question, subquestion)  VALUES (\'2.5.2\',\'Wer der Sozialpädagog*innen könnte Dir dabei helfen?\', \'Die Sozialpädagog*innen in der WG sind ja dazu da, Dich zu unterstützen. Wen willst Du einbeziehen in Dein Veränderungsprojekt?\')',
  'INSERT INTO Question (question_number, question, subquestion)  VALUES (\'2.5.3\',\'Wer aus deiner Familie könnte Dir dabei helfen?\', \'Wen willst Du einweihen und fragen, ob er/sie Dich unterstützt?\')',
  'INSERT INTO Question (question_number, question)               VALUES (\'3.2.1\',\'Ein Gespräch anfangen/andere ansprechen\')',
  'INSERT INTO Question (question_number, question)               VALUES (\'3.2.2\',\'In einer mir bekannten Gruppe etwas sagen/eine Idee vorbringen\')',
  'INSERT INTO Question (question_number, question)               VALUES (\'3.2.3\',\'In einer mir unbekannten Gruppe etwas sagen/eine Idee vorbringen\')',
  'INSERT INTO Question (question_number, question)               VALUES (\'3.2.4\',\'Etwas Lustiges sagen oder machen, andere zum Lachen bringen\')',
  'INSERT INTO Question (question_number, question)               VALUES (\'3.2.5\',\'Jemanden anlächeln/einen Blick zuwerfen\')',
  'INSERT INTO Question (question_number, question)               VALUES (\'3.2.6\',\'Jemanden neugierig machen/Interesse wecken\')',
  'INSERT INTO Question (question_number, question)               VALUES (\'3.3.1\',\'Jemanden nach dem Befinden fragen\')',
  'INSERT INTO Question (question_number, question)               VALUES (\'3.3.2\',\'Jemandem etwas Freundliches sagen/ein Kompliment machen\')',
  'INSERT INTO Question (question_number, question)               VALUES (\'3.3.3\',\'Gut zuhören\')',
  'INSERT INTO Question (question_number, question)               VALUES (\'3.3.4\',\'Jemandem etwas Wichtiges anvertrauen\')',
  'INSERT INTO Question (question_number, question)               VALUES (\'3.3.5\',\'Gemeinsam lachen\')',
  'INSERT INTO Question (question_number, question)               VALUES (\'3.3.6\',\'Auf eine Frage/ein Anliegen eingehen\')',
  'INSERT INTO Question (question_number, question)               VALUES (\'3.3.7\',\'Eigene Irritationen/Schwierigkeiten ansprechen\')',
  'INSERT INTO Question (question_number, question)               VALUES (\'3.4.1\',\'Freude über die Beziehung/das Gespräch zeigen\')',
  'INSERT INTO Question (question_number, question)               VALUES (\'3.4.2\',\'Ansprechen, wie es weitergeht\')',
  'INSERT INTO Question (question_number, question)               VALUES (\'3.4.3\',\'Jemandem ein Feedback geben \')',
  'INSERT INTO Question (question_number, question)               VALUES (\'3.4.4\',\'Weitere Fragen formulieren\')',
  'INSERT INTO Question (question_number, question)               VALUES (\'3.4.5\',\'Um ein weiteres Gespräch bitten\')',
  'INSERT INTO Question (question_number, question)               VALUES (\'3.4.6\',\'Weitere Gesprächsmöglichkeiten ansprechen\')',
];