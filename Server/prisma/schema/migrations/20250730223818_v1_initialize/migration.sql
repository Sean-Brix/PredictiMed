-- CreateTable
CREATE TABLE `accounts` (
    `id` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `role` VARCHAR(191) NOT NULL,
    `isActive` BOOLEAN NOT NULL DEFAULT true,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `profilePictureUrl` VARCHAR(191) NULL,
    `emailVerified` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `accounts_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_profiles` (
    `id` VARCHAR(191) NOT NULL,
    `accountId` VARCHAR(191) NOT NULL,
    `fullName` VARCHAR(191) NOT NULL,
    `dateOfBirth` DATETIME(3) NOT NULL,
    `age` INTEGER NOT NULL,
    `gender` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NOT NULL,
    `contactNumber` VARCHAR(191) NOT NULL,
    `religion` VARCHAR(191) NULL,
    `civilStatus` VARCHAR(191) NOT NULL,
    `occupation` VARCHAR(191) NULL,
    `educationLevel` VARCHAR(191) NULL,
    `philhealthNumber` VARCHAR(191) NULL,
    `nhtsStatus` VARCHAR(191) NULL,
    `personWithDisability` BOOLEAN NOT NULL DEFAULT false,
    `indigenousPeople` BOOLEAN NOT NULL DEFAULT false,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `user_profiles_accountId_key`(`accountId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `health_workers` (
    `id` VARCHAR(191) NOT NULL,
    `accountId` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `role` VARCHAR(191) NOT NULL,
    `contactNumber` VARCHAR(191) NOT NULL,
    `signature` VARCHAR(191) NULL,
    `isActive` BOOLEAN NOT NULL DEFAULT true,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `family_records` (
    `id` VARCHAR(191) NOT NULL,
    `familyId` VARCHAR(191) NOT NULL,
    `headOfFamilyId` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NOT NULL,
    `contactNumber` VARCHAR(191) NOT NULL,
    `smsConsent` BOOLEAN NOT NULL DEFAULT false,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `family_records_familyId_key`(`familyId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `family_members` (
    `id` VARCHAR(191) NOT NULL,
    `familyRecordId` VARCHAR(191) NOT NULL,
    `userProfileId` VARCHAR(191) NULL,
    `memberName` VARCHAR(191) NOT NULL,
    `relationship` VARCHAR(191) NOT NULL,
    `gender` VARCHAR(191) NOT NULL,
    `age` INTEGER NOT NULL,
    `occupation` VARCHAR(191) NULL,
    `civilStatus` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `family_health_histories` (
    `id` VARCHAR(191) NOT NULL,
    `familyRecordId` VARCHAR(191) NOT NULL,
    `geneticConditions` JSON NOT NULL,
    `chronicDiseases` JSON NOT NULL,
    `recordedDate` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `recordedBy` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `family_health_histories_familyRecordId_key`(`familyRecordId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `maternal_health` (
    `id` VARCHAR(191) NOT NULL,
    `userProfileId` VARCHAR(191) NOT NULL,
    `mothersName` VARCHAR(191) NOT NULL,
    `mothersAge` INTEGER NOT NULL,
    `mothersBirthday` DATETIME(3) NOT NULL,
    `mothersMaidenName` VARCHAR(191) NOT NULL,
    `mothersReligion` VARCHAR(191) NULL,
    `mothersEducation` VARCHAR(191) NULL,
    `mothersOccupation` VARCHAR(191) NULL,
    `numberOfChildren` INTEGER NOT NULL,
    `gravidaPara` VARCHAR(191) NOT NULL,
    `menarcheAge` INTEGER NOT NULL,
    `lastMenstrualPeriod` DATETIME(3) NOT NULL,
    `expectedDeliveryDate` DATETIME(3) NOT NULL,
    `tetanusToxoidStatus` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prenatal_visits` (
    `id` VARCHAR(191) NOT NULL,
    `maternalHealthId` VARCHAR(191) NOT NULL,
    `visitDate` DATETIME(3) NOT NULL,
    `gestationalAgeWeeks` INTEGER NOT NULL,
    `weightKg` DOUBLE NOT NULL,
    `heightCm` DOUBLE NOT NULL,
    `bloodPressure` VARCHAR(191) NOT NULL,
    `fundalHeightCm` DOUBLE NOT NULL,
    `fetalHeartTone` VARCHAR(191) NOT NULL,
    `nextVisitDate` DATETIME(3) NULL,
    `recordedBy` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `laboratory_tests` (
    `id` VARCHAR(191) NOT NULL,
    `prenatalVisitId` VARCHAR(191) NOT NULL,
    `userProfileId` VARCHAR(191) NOT NULL,
    `testDate` DATETIME(3) NOT NULL,
    `testType` VARCHAR(191) NOT NULL,
    `testCompleted` BOOLEAN NOT NULL DEFAULT false,
    `recordedBy` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `interventions` (
    `id` VARCHAR(191) NOT NULL,
    `prenatalVisitId` VARCHAR(191) NOT NULL,
    `tetanusToxoidDose` VARCHAR(191) NULL,
    `tetanusToxoidLocation` VARCHAR(191) NULL,
    `tetanusToxoidDate` DATETIME(3) NULL,
    `ironSupplementation` BOOLEAN NOT NULL DEFAULT false,
    `ironMedication` VARCHAR(191) NULL,
    `vitaminSupplementation` BOOLEAN NOT NULL DEFAULT false,
    `vitaminMedication` VARCHAR(191) NULL,
    `calciumSupplementation` BOOLEAN NOT NULL DEFAULT false,
    `calciumMedication` VARCHAR(191) NULL,
    `healthEducationTopics` JSON NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `birth_information` (
    `id` VARCHAR(191) NOT NULL,
    `userProfileId` VARCHAR(191) NOT NULL,
    `maternalHealthId` VARCHAR(191) NOT NULL,
    `placeOfDelivery` VARCHAR(191) NOT NULL,
    `timeOfDelivery` VARCHAR(191) NOT NULL,
    `deliveryType` VARCHAR(191) NOT NULL,
    `birthWeightKg` DOUBLE NOT NULL,
    `birthHeightCm` DOUBLE NOT NULL,
    `newbornScreeningDate` DATETIME(3) NULL,
    `newbornScreeningCompleted` BOOLEAN NOT NULL DEFAULT false,
    `feedingType` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `recordedBy` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `immunization_events` (
    `id` VARCHAR(191) NOT NULL,
    `userProfileId` VARCHAR(191) NOT NULL,
    `visitDate` DATETIME(3) NOT NULL,
    `temperatureCelsius` DOUBLE NULL,
    `weightKg` DOUBLE NULL,
    `heightCm` DOUBLE NULL,
    `adverseReactions` VARCHAR(191) NULL,
    `healthWorkerName` VARCHAR(191) NOT NULL,
    `healthWorkerSignature` VARCHAR(191) NULL,
    `nextFollowupDate` DATETIME(3) NULL,
    `recordedBy` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vaccines_given` (
    `id` VARCHAR(191) NOT NULL,
    `immunizationEventId` VARCHAR(191) NOT NULL,
    `vaccineName` VARCHAR(191) NOT NULL,
    `doseNumber` VARCHAR(191) NOT NULL,
    `dateGiven` DATETIME(3) NOT NULL,
    `lotNumber` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vital_signs` (
    `id` VARCHAR(191) NOT NULL,
    `userProfileId` VARCHAR(191) NOT NULL,
    `recordDate` DATETIME(3) NOT NULL,
    `bloodPressure` VARCHAR(191) NULL,
    `heartRate` INTEGER NULL,
    `respiratoryRate` INTEGER NULL,
    `temperatureCelsius` DOUBLE NULL,
    `pulseRate` INTEGER NULL,
    `recordedBy` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `anthropometric_measurements` (
    `id` VARCHAR(191) NOT NULL,
    `userProfileId` VARCHAR(191) NOT NULL,
    `measurementDate` DATETIME(3) NOT NULL,
    `weightKg` DOUBLE NULL,
    `heightCm` DOUBLE NULL,
    `headCircumferenceCm` DOUBLE NULL,
    `waistCircumferenceCm` DOUBLE NULL,
    `bmi` DOUBLE NULL,
    `recordedBy` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `growth_tracking` (
    `id` VARCHAR(191) NOT NULL,
    `userProfileId` VARCHAR(191) NOT NULL,
    `trackingDate` DATETIME(3) NOT NULL,
    `weightForAge` VARCHAR(191) NULL,
    `heightForAge` VARCHAR(191) NULL,
    `weightForHeight` VARCHAR(191) NULL,
    `recordedBy` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ncd_risk_assessments` (
    `id` VARCHAR(191) NOT NULL,
    `userProfileId` VARCHAR(191) NOT NULL,
    `assessmentDate` DATETIME(3) NOT NULL,
    `smokingStatus` VARCHAR(191) NULL,
    `alcoholIntake` VARCHAR(191) NULL,
    `physicalActivity` VARCHAR(191) NULL,
    `fruitVegetableIntake` VARCHAR(191) NULL,
    `familyHistoryDiabetes` BOOLEAN NOT NULL DEFAULT false,
    `familyHistoryHypertension` BOOLEAN NOT NULL DEFAULT false,
    `familyHistoryHeartDisease` BOOLEAN NOT NULL DEFAULT false,
    `familyHistoryStroke` BOOLEAN NOT NULL DEFAULT false,
    `screeningCompleted` BOOLEAN NOT NULL DEFAULT false,
    `followUpNeeded` BOOLEAN NOT NULL DEFAULT false,
    `lifestyleModifications` JSON NOT NULL,
    `healthEducationReceived` JSON NOT NULL,
    `recordedBy` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `visit_records` (
    `id` VARCHAR(191) NOT NULL,
    `userProfileId` VARCHAR(191) NOT NULL,
    `visitDate` DATETIME(3) NOT NULL,
    `visitType` VARCHAR(191) NOT NULL,
    `visitFrequency` VARCHAR(191) NULL,
    `referred` BOOLEAN NOT NULL DEFAULT false,
    `facilityName` VARCHAR(191) NULL,
    `referralReason` VARCHAR(191) NULL,
    `recordedBy` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `health_education` (
    `id` VARCHAR(191) NOT NULL,
    `userProfileId` VARCHAR(191) NOT NULL,
    `topicsCovered` JSON NOT NULL,
    `dateProvided` DATETIME(3) NOT NULL,
    `providedBy` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `nutritional_counseling` (
    `id` VARCHAR(191) NOT NULL,
    `userProfileId` VARCHAR(191) NOT NULL,
    `recommendations` VARCHAR(191) NOT NULL,
    `dateProvided` DATETIME(3) NOT NULL,
    `providedBy` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `referrals` (
    `id` VARCHAR(191) NOT NULL,
    `userProfileId` VARCHAR(191) NOT NULL,
    `facilityName` VARCHAR(191) NOT NULL,
    `reason` VARCHAR(191) NOT NULL,
    `dateReferred` DATETIME(3) NOT NULL,
    `status` VARCHAR(191) NOT NULL,
    `referredBy` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `appointments` (
    `id` VARCHAR(191) NOT NULL,
    `userProfileId` VARCHAR(191) NOT NULL,
    `nextVisitDate` DATETIME(3) NOT NULL,
    `visitType` VARCHAR(191) NOT NULL,
    `appointmentStatus` VARCHAR(191) NOT NULL,
    `scheduledBy` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `immunization_reminders` (
    `id` VARCHAR(191) NOT NULL,
    `userProfileId` VARCHAR(191) NOT NULL,
    `vaccineName` VARCHAR(191) NOT NULL,
    `dueDate` DATETIME(3) NOT NULL,
    `reminderSent` BOOLEAN NOT NULL DEFAULT false,
    `sentAt` DATETIME(3) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `test_reminders` (
    `id` VARCHAR(191) NOT NULL,
    `userProfileId` VARCHAR(191) NOT NULL,
    `testName` VARCHAR(191) NOT NULL,
    `dueDate` DATETIME(3) NOT NULL,
    `reminderSent` BOOLEAN NOT NULL DEFAULT false,
    `sentAt` DATETIME(3) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `virtual_checkups` (
    `id` VARCHAR(191) NOT NULL,
    `userProfileId` VARCHAR(191) NOT NULL,
    `healthWorkerId` VARCHAR(191) NOT NULL,
    `scheduledDate` DATETIME(3) NOT NULL,
    `scheduledTime` VARCHAR(191) NOT NULL,
    `meetingUrl` VARCHAR(191) NULL,
    `status` VARCHAR(191) NOT NULL,
    `consultationType` VARCHAR(191) NULL,
    `chiefComplaint` VARCHAR(191) NULL,
    `notes` VARCHAR(191) NULL,
    `durationMinutes` INTEGER NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `virtual_checkup_notes` (
    `id` VARCHAR(191) NOT NULL,
    `virtualCheckupId` VARCHAR(191) NOT NULL,
    `note` VARCHAR(191) NOT NULL,
    `createdBy` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `events` (
    `id` VARCHAR(191) NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NOT NULL,
    `eventType` VARCHAR(191) NOT NULL,
    `eventDate` DATETIME(3) NOT NULL,
    `startTime` VARCHAR(191) NOT NULL,
    `endTime` VARCHAR(191) NOT NULL,
    `venue` VARCHAR(191) NOT NULL,
    `targetAudience` VARCHAR(191) NULL,
    `maxParticipants` INTEGER NULL,
    `status` VARCHAR(191) NOT NULL,
    `bannerImageUrl` VARCHAR(191) NULL,
    `createdBy` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `event_registrations` (
    `id` VARCHAR(191) NOT NULL,
    `eventId` VARCHAR(191) NOT NULL,
    `userProfileId` VARCHAR(191) NOT NULL,
    `registrationDate` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `status` VARCHAR(191) NOT NULL,
    `notes` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `medical_programs` (
    `id` VARCHAR(191) NOT NULL,
    `programName` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NOT NULL,
    `programType` VARCHAR(191) NOT NULL,
    `startDate` DATETIME(3) NOT NULL,
    `endDate` DATETIME(3) NOT NULL,
    `venue` VARCHAR(191) NOT NULL,
    `targetDemographic` VARCHAR(191) NULL,
    `targetParticipants` INTEGER NULL,
    `status` VARCHAR(191) NOT NULL,
    `bannerImageUrl` VARCHAR(191) NULL,
    `createdBy` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `program_participations` (
    `id` VARCHAR(191) NOT NULL,
    `medicalProgramId` VARCHAR(191) NOT NULL,
    `userProfileId` VARCHAR(191) NOT NULL,
    `participationDate` DATETIME(3) NOT NULL,
    `status` VARCHAR(191) NOT NULL,
    `servicesReceived` VARCHAR(191) NULL,
    `notes` VARCHAR(191) NULL,
    `recordedBy` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inquiries` (
    `id` VARCHAR(191) NOT NULL,
    `userProfileId` VARCHAR(191) NOT NULL,
    `subject` VARCHAR(191) NOT NULL,
    `message` VARCHAR(191) NOT NULL,
    `priority` VARCHAR(191) NOT NULL,
    `status` VARCHAR(191) NOT NULL,
    `category` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inquiry_responses` (
    `id` VARCHAR(191) NOT NULL,
    `inquiryId` VARCHAR(191) NOT NULL,
    `message` VARCHAR(191) NOT NULL,
    `respondedBy` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `surveys` (
    `id` VARCHAR(191) NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NOT NULL,
    `surveyType` VARCHAR(191) NOT NULL,
    `isActive` BOOLEAN NOT NULL DEFAULT true,
    `startDate` DATETIME(3) NOT NULL,
    `endDate` DATETIME(3) NOT NULL,
    `qrCode` VARCHAR(191) NULL,
    `createdBy` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `survey_questions` (
    `id` VARCHAR(191) NOT NULL,
    `surveyId` VARCHAR(191) NOT NULL,
    `questionText` VARCHAR(191) NOT NULL,
    `questionType` VARCHAR(191) NOT NULL,
    `options` JSON NOT NULL,
    `isRequired` BOOLEAN NOT NULL DEFAULT false,
    `orderIndex` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `survey_responses` (
    `id` VARCHAR(191) NOT NULL,
    `surveyId` VARCHAR(191) NOT NULL,
    `userProfileId` VARCHAR(191) NOT NULL,
    `ipAddress` VARCHAR(191) NULL,
    `submittedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `survey_answers` (
    `id` VARCHAR(191) NOT NULL,
    `surveyResponseId` VARCHAR(191) NOT NULL,
    `surveyQuestionId` VARCHAR(191) NOT NULL,
    `answer` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `analytics_reports` (
    `id` VARCHAR(191) NOT NULL,
    `reportName` VARCHAR(191) NOT NULL,
    `reportType` VARCHAR(191) NOT NULL,
    `dataFilters` JSON NOT NULL,
    `reportData` JSON NOT NULL,
    `reportPeriodStart` DATETIME(3) NOT NULL,
    `reportPeriodEnd` DATETIME(3) NOT NULL,
    `generatedBy` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prediction_models` (
    `id` VARCHAR(191) NOT NULL,
    `modelName` VARCHAR(191) NOT NULL,
    `modelType` VARCHAR(191) NOT NULL,
    `modelParameters` JSON NOT NULL,
    `predictionResults` JSON NULL,
    `accuracy` DOUBLE NULL,
    `lastTrained` DATETIME(3) NULL,
    `isActive` BOOLEAN NOT NULL DEFAULT true,
    `createdBy` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `system_logs` (
    `id` VARCHAR(191) NOT NULL,
    `userId` VARCHAR(191) NOT NULL,
    `action` VARCHAR(191) NOT NULL,
    `entityType` VARCHAR(191) NOT NULL,
    `entityId` VARCHAR(191) NOT NULL,
    `oldData` JSON NULL,
    `newData` JSON NULL,
    `ipAddress` VARCHAR(191) NULL,
    `userAgent` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `user_profiles` ADD CONSTRAINT `user_profiles_accountId_fkey` FOREIGN KEY (`accountId`) REFERENCES `accounts`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `health_workers` ADD CONSTRAINT `health_workers_accountId_fkey` FOREIGN KEY (`accountId`) REFERENCES `accounts`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `family_records` ADD CONSTRAINT `family_records_headOfFamilyId_fkey` FOREIGN KEY (`headOfFamilyId`) REFERENCES `user_profiles`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `family_members` ADD CONSTRAINT `family_members_familyRecordId_fkey` FOREIGN KEY (`familyRecordId`) REFERENCES `family_records`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `family_members` ADD CONSTRAINT `family_members_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `user_profiles`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `family_health_histories` ADD CONSTRAINT `family_health_histories_familyRecordId_fkey` FOREIGN KEY (`familyRecordId`) REFERENCES `family_records`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `maternal_health` ADD CONSTRAINT `maternal_health_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `user_profiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `prenatal_visits` ADD CONSTRAINT `prenatal_visits_maternalHealthId_fkey` FOREIGN KEY (`maternalHealthId`) REFERENCES `maternal_health`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `laboratory_tests` ADD CONSTRAINT `laboratory_tests_prenatalVisitId_fkey` FOREIGN KEY (`prenatalVisitId`) REFERENCES `prenatal_visits`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `interventions` ADD CONSTRAINT `interventions_prenatalVisitId_fkey` FOREIGN KEY (`prenatalVisitId`) REFERENCES `prenatal_visits`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `birth_information` ADD CONSTRAINT `birth_information_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `user_profiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `birth_information` ADD CONSTRAINT `birth_information_maternalHealthId_fkey` FOREIGN KEY (`maternalHealthId`) REFERENCES `maternal_health`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `immunization_events` ADD CONSTRAINT `immunization_events_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `user_profiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `vaccines_given` ADD CONSTRAINT `vaccines_given_immunizationEventId_fkey` FOREIGN KEY (`immunizationEventId`) REFERENCES `immunization_events`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `vital_signs` ADD CONSTRAINT `vital_signs_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `user_profiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `anthropometric_measurements` ADD CONSTRAINT `anthropometric_measurements_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `user_profiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `growth_tracking` ADD CONSTRAINT `growth_tracking_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `user_profiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ncd_risk_assessments` ADD CONSTRAINT `ncd_risk_assessments_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `user_profiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `visit_records` ADD CONSTRAINT `visit_records_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `user_profiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `health_education` ADD CONSTRAINT `health_education_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `user_profiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `nutritional_counseling` ADD CONSTRAINT `nutritional_counseling_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `user_profiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `referrals` ADD CONSTRAINT `referrals_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `user_profiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `appointments` ADD CONSTRAINT `appointments_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `user_profiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `immunization_reminders` ADD CONSTRAINT `immunization_reminders_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `user_profiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `test_reminders` ADD CONSTRAINT `test_reminders_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `user_profiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `virtual_checkups` ADD CONSTRAINT `virtual_checkups_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `user_profiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `virtual_checkups` ADD CONSTRAINT `virtual_checkups_healthWorkerId_fkey` FOREIGN KEY (`healthWorkerId`) REFERENCES `health_workers`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `virtual_checkup_notes` ADD CONSTRAINT `virtual_checkup_notes_virtualCheckupId_fkey` FOREIGN KEY (`virtualCheckupId`) REFERENCES `virtual_checkups`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `events` ADD CONSTRAINT `events_createdBy_fkey` FOREIGN KEY (`createdBy`) REFERENCES `accounts`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `event_registrations` ADD CONSTRAINT `event_registrations_eventId_fkey` FOREIGN KEY (`eventId`) REFERENCES `events`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `event_registrations` ADD CONSTRAINT `event_registrations_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `user_profiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `medical_programs` ADD CONSTRAINT `medical_programs_createdBy_fkey` FOREIGN KEY (`createdBy`) REFERENCES `accounts`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `program_participations` ADD CONSTRAINT `program_participations_medicalProgramId_fkey` FOREIGN KEY (`medicalProgramId`) REFERENCES `medical_programs`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `program_participations` ADD CONSTRAINT `program_participations_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `user_profiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `inquiries` ADD CONSTRAINT `inquiries_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `user_profiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `inquiry_responses` ADD CONSTRAINT `inquiry_responses_inquiryId_fkey` FOREIGN KEY (`inquiryId`) REFERENCES `inquiries`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `inquiry_responses` ADD CONSTRAINT `inquiry_responses_respondedBy_fkey` FOREIGN KEY (`respondedBy`) REFERENCES `accounts`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `surveys` ADD CONSTRAINT `surveys_createdBy_fkey` FOREIGN KEY (`createdBy`) REFERENCES `accounts`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `survey_questions` ADD CONSTRAINT `survey_questions_surveyId_fkey` FOREIGN KEY (`surveyId`) REFERENCES `surveys`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `survey_responses` ADD CONSTRAINT `survey_responses_surveyId_fkey` FOREIGN KEY (`surveyId`) REFERENCES `surveys`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `survey_responses` ADD CONSTRAINT `survey_responses_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `user_profiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `survey_answers` ADD CONSTRAINT `survey_answers_surveyResponseId_fkey` FOREIGN KEY (`surveyResponseId`) REFERENCES `survey_responses`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `survey_answers` ADD CONSTRAINT `survey_answers_surveyQuestionId_fkey` FOREIGN KEY (`surveyQuestionId`) REFERENCES `survey_questions`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `analytics_reports` ADD CONSTRAINT `analytics_reports_generatedBy_fkey` FOREIGN KEY (`generatedBy`) REFERENCES `accounts`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `prediction_models` ADD CONSTRAINT `prediction_models_createdBy_fkey` FOREIGN KEY (`createdBy`) REFERENCES `accounts`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `system_logs` ADD CONSTRAINT `system_logs_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `accounts`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
