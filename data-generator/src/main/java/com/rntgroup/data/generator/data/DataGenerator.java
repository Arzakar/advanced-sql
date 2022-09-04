package com.rntgroup.data.generator.data;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.nio.file.Files;
import java.time.LocalDate;
import java.util.List;

@Component
public class DataGenerator implements CommandLineRunner {

    @Autowired
    private JdbcTemplate template;

    private final ObjectMapper objectMapper = new ObjectMapper();
    private String[] womanNames;
    private String[] manNames;
    private String[] surnames;
    private String[] subjects;

    @Override
    public void run(String... args) throws Exception {
        womanNames = objectMapper.readValue(readAsString("woman-names.json"), String[].class);
        manNames = objectMapper.readValue(readAsString("man-names.json"), String[].class);
        surnames = objectMapper.readValue(readAsString("surnames.json"), String[].class);
        subjects = objectMapper.readValue(readAsString("subjects.json"), String[].class);

        generateStudents();
        generateSubjects();
        generateExamResults();
    }

    private void generateStudents() {
        int studentsCount = template.queryForObject("SELECT COUNT(*) FROM students", Integer.class);
        if (studentsCount != 0) {
            return;
        }

        for (int i = 0; i < 100_000; i++) {
            byte sex = (byte) Math.round(Math.random());

            String name = sex == 0
                    ? womanNames[(int) (Math.random() * (womanNames.length - 1))]
                    : manNames[(int) (Math.random() * (manNames.length - 1))];

            String surname = surnames[(int) (Math.random() * (surnames.length - 1))];
            if (sex == 0) {
                surname += "a";
            }

            int year = (int) (Math.random() * 4) + 18;
            int month = (int) (Math.random() * 12);
            int day = (int) (Math.random() * 30) + 1;
            LocalDate birthday = LocalDate.now()
                    .minusYears(year)
                    .minusMonths(month)
                    .minusDays(day);

            StringBuilder phone = new StringBuilder("+7");
            for (int j = 0; j < 10; j++) {
                phone.append((int) (Math.random() * 9));
            }

            String skill = subjects[(int) (Math.random() * (subjects.length - 1))];

            String query = String.format("INSERT INTO students (\"name\", surname, birthday, phone, skill)\n" +
                                         "VALUES ('%s', '%s', '%s', '%s', '%s')", name, surname, birthday, phone, skill);

            template.execute(query);
        }
    }

    private void generateSubjects() {
        int subjectsCount = template.queryForObject("SELECT COUNT(*) FROM subjects", Integer.class);
        if (subjectsCount != 0) {
            return;
        }

        for (String subject : subjects) {
            String tutor = (byte) Math.round(Math.random()) == 0
                    ? womanNames[(int) (Math.random() * (womanNames.length - 1))]
                    : manNames[(int) (Math.random() * (manNames.length - 1))];

            String query = String.format("INSERT INTO subjects (\"name\", tutor)\n" +
                                         "VALUES ('%s', '%s')", subject, tutor);

            template.execute(query);
        }
    }

    private void generateExamResults() {
        int examResultsCount = template.queryForObject("SELECT COUNT(*) FROM exam_results", Integer.class);
        if (examResultsCount != 0) {
            return;
        }

        List<Integer> studentIds = template.queryForList("SELECT id FROM students", Integer.class);
        List<Integer> subjectIds = template.queryForList("SELECT id FROM subjects", Integer.class);

        for (int studentId : studentIds) {
            for (int i = 0; i < 10; i++) {
                int subjectId = subjectIds.get((int) (Math.random() * (subjectIds.size() - 1)));
                int mark = (int) (Math.random() * 9) + 1;

                String query = String.format("INSERT INTO exam_results (student_id, subject_id, mark)\n" +
                                             "VALUES (%d, %d, %d)", studentId, subjectId, mark);

                template.execute(query);
            }
        }
    }

    private String readAsString(String filePath) throws IOException {
        return Files.readString(new ClassPathResource(filePath).getFile().toPath());
    }
}
