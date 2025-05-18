# Library-Management-System
Error Log:

-- Error Scenario 1: Delete a member who has existing loans
DELETE FROM Member WHERE MemberID = 1;

-- Error Scenario 2: Delete a book that is currently on loan
DELETE FROM Book WHERE BookID = 1;

-- Error Scenario 3: Insert a loan for a non-existent member
INSERT INTO Loan (LoanDate, DueDate, Status, MemberID, BookID) VALUES ('2025-05-15', '2025-05-25', 'Issued', 99, 2);

-- Error Scenario 4: Insert a loan for a non-existent book
INSERT INTO Loan (LoanDate, DueDate, Status, MemberID, BookID) VALUES ('2025-05-15', '2025-05-25', 'Issued', 1, 99);

-- Error Scenario 5: Update a book's genre to an invalid value
UPDATE Book SET Genre = 'Sci-Fi' WHERE BookID = 1;

-- Error Scenario 6: Insert a payment with zero amount
INSERT INTO Payment (PaymentDate, Amount, PaymentMethod, LoanID) VALUES ('2025-05-21', 0, 'Cash', 1);

-- Error Scenario 7: Insert a review for a non-existent book
INSERT INTO Review (Rating, Comments, ReviewDate, MemberID, BookID) VALUES (4, 'Not bad', '2025-05-15', 1, 99);

-- Error Scenario 8: Update a foreign key (MemberID in Loan) to a non-existent value
UPDATE Loan SET MemberID = 99 WHERE LoanID = 1;
