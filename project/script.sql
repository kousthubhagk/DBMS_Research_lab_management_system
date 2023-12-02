-- Create the ResearchLabManagementSystem database
CREATE DATABASE IF NOT EXISTS ResearchLabManagementSystem;
USE ResearchLabManagementSystem;

-- Create the ResearchLab table
CREATE TABLE ResearchLab (
    LabID INT PRIMARY KEY,
    LabName VARCHAR(50),
    LabComponents VARCHAR(50),
    LabComponentsDetails VARCHAR(200)
);

-- Create the LabPersonnel table
CREATE TABLE LabPersonnel (
    PersonnelID INT PRIMARY KEY,
    PersonnelName VARCHAR(50),
    LabID INT,
    FOREIGN KEY (LabID) REFERENCES ResearchLab(LabID)
);

-- Create the Teacher table
CREATE TABLE Teacher (
    TeacherID INT PRIMARY KEY,
    TeacherName VARCHAR(50),
    TeacherRole VARCHAR(20)
);

-- Create the Student table
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    LabID INT,
    ClassesAttended INT DEFAULT 0,
    FOREIGN KEY (LabID) REFERENCES ResearchLab(LabID)
);

-- Create the ProjectProposal table
CREATE TABLE ProjectProposal (
    ProposalID INT AUTO_INCREMENT PRIMARY KEY,
    ProposalTitle VARCHAR(100),
    ProposalDesc VARCHAR(200),
    ProposalSubmissionDate DATE,
    LabID INT,
    TeacherApprovedStatus ENUM('approved', 'not approved') DEFAULT 'not approved',
    DirectorApprovedStatus ENUM('approved', 'not approved') DEFAULT 'not approved',
    ApprovedID INT DEFAULT NULL,
    StudentID INT DEFAULT NULL,
    FOREIGN KEY (LabID) REFERENCES ResearchLab(LabID),
    FOREIGN KEY (ApprovedID) REFERENCES Teacher(TeacherID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);

-- Create the Project table
CREATE TABLE Project (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    ProjectStatus ENUM('ongoing', 'finished', 'pending'),
    ProjectStartDate DATE,
    ProjectEndDate DATE,
    MentorID INT,
    StudentID INT,
    LabID INT,
    ProposalID INT,
    ProjectType VARCHAR(20),
    FOREIGN KEY (LabID) REFERENCES ResearchLab(LabID),
    FOREIGN KEY (MentorID) REFERENCES Teacher(TeacherID),
    FOREIGN KEY (ProposalID) REFERENCES ProjectProposal(ProposalID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);

-- Create the Eventss table
CREATE TABLE Eventss (
    EventID INT PRIMARY KEY,
    EventName VARCHAR(50),
    EventDate DATE,
    LabID INT,
    ManagerID INT,
    CashPrize INT,
    Winner VARCHAR(50),
    WinnerID INT,
    FOREIGN KEY (LabID) REFERENCES ResearchLab(LabID),
    FOREIGN KEY (ManagerID) REFERENCES Teacher(TeacherID),
    FOREIGN KEY (WinnerID) REFERENCES Student(StudentID)
);

-- Create the stipend table
CREATE TABLE Stipend (
    StipendID INT PRIMARY KEY,
    StipendAmount INT,
    StipendDate DATE,
    StudentID INT,
    LabID INT,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (LabID) REFERENCES ResearchLab(LabID)
);

-- Create the AttendanceRecord table
CREATE TABLE AttendanceRecord (
    RecordID INT PRIMARY KEY,
    RecordType VARCHAR(20),
    DateOfEntry DATE,
    EntryTime TIME,
    ExitTime TIME,
    Signature INT,
    StudentID INT,
    TeacherID INT,
    LabID INT,
    AttendanceStatus VARCHAR(10) DEFAULT 'Absent'
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (TeacherID) REFERENCES Teacher(TeacherID),
    FOREIGN KEY (LabID) REFERENCES ResearchLab(LabID)
);

INSERT INTO ResearchLab (LabID, LabName, LabComponents, LabComponentsDetails) VALUES
(1, 'Centre for Intelligent Systems', 'Sensors, Robotics', 'Advanced equipment for intelligent systems research'),
(2, 'Centre for Cloud Computing & Big Data', 'Servers, Cloud infrastructure', 'Lab for cloud computing and big data research'),
(3, 'Knowledge Analytics & Ontological Eng.', 'Data analytics tools, Ontology software', 'Lab for knowledge analytics and ontological engineering'),
(4, 'Center for Pattern Recognition', 'Cameras, Image processing tools', 'Lab for pattern recognition research'),
(5, 'Centre for Research in Space Science', 'Telescopes, Satellite communication equipment', 'Lab for space science and technology research'),
(6, 'Center for Data Sciences & Applied ML', 'Machine learning algorithms, Data processing tools', 'Lab for data sciences and applied machine learning'),
(7, 'Center of Excellence in Info. Security', 'Firewalls, Forensic tools', 'Lab for information security, forensics, and cyber resilience'),
(8, 'Center of Excellence in IoT', 'IoT devices, Sensors', 'Lab for Internet of Things (IoT) research');

-- Insert data into LabPersonnel table
INSERT INTO LabPersonnel (PersonnelID, PersonnelName, LabID) VALUES
(1, 'Dr. Smith', 1),
(2, 'Prof. Johnson', 2),
(3, 'Dr. Brown', 3),
(4, 'Prof. Davis', 4),
(5, 'Dr. Wilson', 5),
(6, 'Prof. Turner', 6),
(7, 'Dr. Harris', 7),
(8, 'Prof. Miller', 8);

-- Insert data into Teacher table
INSERT INTO Teacher (TeacherID, TeacherName, TeacherRole) VALUES
(1, 'Dr. Smith', 'Professor'),
(2, 'Prof. Johnson', 'Associate Professor'),
(3, 'Dr. Brown', 'Professor'),
(4, 'Prof. Davis', 'Associate Professor'),
(5, 'Dr. Wilson', 'Professor'),
(6, 'Prof. Turner', 'Assistant Professor'),
(7, 'Dr. Harris', 'Professor'),
(8, 'Prof. Miller', 'Associate Professor');

-- Insert data into Student table
INSERT INTO Student (StudentID, StudentName, LabID) VALUES
(1, 'Alice Smith', 1),
(2, 'Bob Johnson', 2),
(3, 'Eva Brown', 3),
(4, 'Charlie Davis', 4),
(5, 'Grace Wilson', 5),
(6, 'David Turner', 6),
(7, 'Sophie Harris', 7),
(8, 'Michael Miller', 8);

-- Insert data into ProjectProposal table
INSERT INTO ProjectProposal (ProposalTitle, ProposalDesc, ProposalSubmissionDate, LabID, TeacherApprovedStatus, DirectorApprovedStatus, ApprovedID, StudentID) VALUES
('Intelligent Systems Project', 'Developing smart devices', '2023-01-15', 1, 'approved', 'approved', 1, 1),
('Cloud Computing Research', 'Exploring cloud technologies', '2023-02-01', 2, 'not approved', 'approved', 2, 2),
('Ontological Engineering Study', 'Building ontologies for knowledge representation', '2023-03-01', 3, 'not approved', 'approved', 3, 3),
('Pattern Recognition Project', 'Image recognition algorithms', '2023-04-15', 4, 'approved', 'approved', 4, 4),
('Space Science Investigation', 'Studying celestial bodies', '2023-05-10', 5, 'approved', 'not approved', 5, 5),
('Applied Machine Learning in Data Sciences', 'Utilizing ML in data analysis', '2023-06-05', 6, 'not approved', 'not approved', NULL, 6),
('Information Security Research', 'Enhancing cybersecurity measures', '2023-07-20', 7, 'approved', 'approved', 7, 7),
('Internet of Things (IoT) Project', 'Creating interconnected devices', '2023-08-12', 8, 'approved', 'approved', 8, 8);


-- Insert data into Project table
INSERT INTO Project (ProjectID, ProjectName, ProjectStatus, ProjectStartDate, ProjectEndDate, MentorID, StudentID, LabID, ProposalID, ProjectType) VALUES
(1, 'Smart Device Prototype', 'ongoing', '2023-01-20', '2023-05-20', 1, 1, 1, 1, 'Research'),
(2, 'Cloud Storage Solutions', 'finished', '2023-02-10', '2023-04-30', 2, 2, 2, 2, 'Development'),
(3, 'Ontology Builder Tool', 'ongoing', '2023-03-15', '2023-08-15', 3, 3, 3, 3, 'Research'),
(4, 'Image Recognition Software', 'pending', NULL, NULL, 4, 4, 4, 4, 'Development'),
(5, 'Satellite Communication System', 'finished', '2023-05-20', '2023-09-30', 5, 5, 5, 5, 'Research'),
(6, 'Data Analysis Platform', 'ongoing', '2023-06-10', '2023-12-10', 6, 6, 6, 6, 'Development'),
(7, 'Cybersecurity Framework', 'pending', NULL, NULL, 7, 7, 7, 7, 'Research'),
(8, 'IoT Device Prototypes', 'pending', NULL, NULL, 8, 8, 8, 8, 'Development');

-- Insert data into Eventss table
INSERT INTO Eventss (EventID, EventName, EventDate, LabID, ManagerID, CashPrize, Winner, WinnerID) VALUES
(1, 'Innovation Expo 2023', '2023-04-01', 1, 1, 1000, 'Project 1 Team', 1),
(2, 'Tech Symposium 2023', '2023-05-15', 2, 2, 1500, 'Project 2 Team', 2),
(3, 'Knowledge Summit 2023', '2023-06-20', 3, 3, 1200, 'Project 3 Team', 3),
(4, 'Pattern Recognition Conference', '2023-07-10', 4, 4, 800, 'Project 4 Team', 4),
(5, 'Space Tech Expo 2023', '2023-08-25', 5, 5, 2000, 'Project 5 Team', 5),
(6, 'Data Science Convention', '2023-09-15', 6, 6, 1800, 'Project 6 Team', 6),
(7, 'Cybersecurity Summit 2023', '2023-10-05', 7, 7, 1600, 'Project 7 Team', 7),
(8, 'IoT World 2023', '2023-11-20', 8, 8, 2200, 'Project 8 Team', 8);

-- Insert data into Stipend table
INSERT INTO Stipend (StipendID, StipendAmount, StipendDate, StudentID, LabID) VALUES
(1, 500, '2023-05-01', 1, 1),
(2, 600, '2023-05-15', 2, 2),
(3, 550, '2023-06-01', 3, 3),
(4, 700, '2023-06-15', 4, 4),
(5, 800, '2023-07-01', 5, 5),
(6, 750, '2023-07-15', 6, 6),
(7, 900, '2023-08-01', 7, 7),
(8, 1000, '2023-08-15', 8, 8);

-- Insert data into AttendanceRecord table
INSERT INTO AttendanceRecord (RecordID, RecordType, DateOfEntry, EntryTime, ExitTime, Signature, StudentID, TeacherID, LabID) VALUES
(1, 'Class', '2023-05-01', '09:00:00', '12:00:00', 1, 1, 1, 1),
(2, 'Lab', '2023-05-02', '10:00:00', '13:00:00', 1, 2, 2, 2),
(3, 'Class', '2023-05-03', '11:00:00', '14:00:00', 1, 3, 3, 3),
(4, 'Lab', '2023-05-04', '12:00:00', '15:00:00', 1, 4, 4, 4),
(5, 'Class', '2023-05-05', '13:00:00', '16:00:00', 1, 5, 5, 5),
(6, 'Lab', '2023-05-06', '14:00:00', '17:00:00', 1, 6, 6, 6),
(7, 'Class', '2023-05-07', '15:00:00', '18:00:00', 1, 7, 7, 7),
(8, 'Lab', '2023-05-08', '16:00:00', '19:00:00', 1, 8, 8, 8);

-- -- Adding a new attribute 'ClassesAttended' in the Student table
-- ALTER TABLE Student
-- ADD COLUMN ClassesAttended INT DEFAULT 0;

-- -- Modifying the AttendanceRecord table
-- ALTER TABLE AttendanceRecord
-- ADD COLUMN AttendanceStatus VARCHAR(10) DEFAULT 'Absent';
