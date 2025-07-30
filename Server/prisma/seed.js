import { PrismaClient } from './generated/client.js';
import bcrypt from 'bcrypt';
import { faker } from '@faker-js/faker';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const prisma = new PrismaClient();
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const wait = (ms) => new Promise((res) => setTimeout(res, ms));

//? ========================================= ACCOUNTS ========================================= ?//

async function createAccounts() {
    console.log('Creating accounts...');

    // Create Super Admin
    const superAdmin = await prisma.account.create({
        data: {
            email: 'admin@predictimed.com',
            password: await bcrypt.hash('admin123', 10),
            role: 'SUPER_ADMIN',
            isActive: true,
            emailVerified: true,
            userProfile: {
                create: {
                    fullName: 'System Administrator',
                    dateOfBirth: new Date('1990-01-01'),
                    age: 34,
                    gender: 'Male',
                    address: 'System Office, Admin Building',
                    contactNumber: '+63-123-456-7890',
                    civilStatus: 'Single',
                    occupation: 'System Administrator',
                    educationLevel: 'College Graduate',
                },
            },
        },
    });

    // Create Health Workers
    for (let i = 0; i < 10; i++) {
        const firstName = faker.person.firstName();
        const lastName = faker.person.lastName();
        const email = `${firstName.toLowerCase()}.${lastName.toLowerCase()}@health.gov.ph`;

        await prisma.account.create({
            data: {
                email: email,
                password: await bcrypt.hash('health123', 10),
                role: 'HEALTH_WORKER',
                isActive: true,
                emailVerified: true,
                userProfile: {
                    create: {
                        fullName: `${firstName} ${lastName}`,
                        dateOfBirth: faker.date.birthdate({
                            min: 25,
                            max: 60,
                            mode: 'age',
                        }),
                        age: faker.number.int({ min: 25, max: 60 }),
                        gender:
                            faker.person.sexType() === 'male'
                                ? 'Male'
                                : 'Female',
                        address:
                            faker.location.streetAddress() +
                            ', ' +
                            faker.location.city(),
                        contactNumber: faker.phone.number('+63-9##-###-####'),
                        civilStatus: faker.helpers.arrayElement([
                            'Single',
                            'Married',
                            'Widowed',
                            'Separated',
                        ]),
                        occupation: faker.helpers.arrayElement([
                            'Nurse',
                            'Midwife',
                            'Doctor',
                            'Health Technician',
                        ]),
                        educationLevel: faker.helpers.arrayElement([
                            'High School',
                            'College Graduate',
                            'Masters',
                            'Doctorate',
                        ]),
                        philhealthNumber: faker.string.numeric(12),
                        nhtsStatus: faker.helpers.arrayElement([
                            'Active',
                            'Inactive',
                            'Graduated',
                        ]),
                    },
                },
                healthWorkers: {
                    create: {
                        name: `${firstName} ${lastName}`,
                        role: faker.helpers.arrayElement([
                            'Nurse',
                            'Midwife',
                            'Doctor',
                            'Health Technician',
                        ]),
                        contactNumber: faker.phone.number('+63-9##-###-####'),
                        signature: null,
                        isActive: true,
                    },
                },
            },
        });

        await wait(100);
    }

    // Create regular users (families)
    for (let i = 0; i < 50; i++) {
        const firstName = faker.person.firstName();
        const lastName = faker.person.lastName();
        const email = `${firstName.toLowerCase()}.${lastName.toLowerCase()}@gmail.com`;

        await prisma.account.create({
            data: {
                email: email,
                password: await bcrypt.hash('user123', 10),
                role: 'USER',
                isActive: true,
                emailVerified: faker.datatype.boolean(),
                userProfile: {
                    create: {
                        fullName: `${firstName} ${lastName}`,
                        dateOfBirth: faker.date.birthdate({
                            min: 18,
                            max: 80,
                            mode: 'age',
                        }),
                        age: faker.number.int({ min: 18, max: 80 }),
                        gender:
                            faker.person.sexType() === 'male'
                                ? 'Male'
                                : 'Female',
                        address:
                            faker.location.streetAddress() +
                            ', ' +
                            faker.location.city(),
                        contactNumber: faker.phone.number('+63-9##-###-####'),
                        religion: faker.helpers.arrayElement([
                            'Catholic',
                            'Protestant',
                            'Islam',
                            'Others',
                        ]),
                        civilStatus: faker.helpers.arrayElement([
                            'Single',
                            'Married',
                            'Widowed',
                            'Separated',
                        ]),
                        occupation: faker.person.jobTitle(),
                        educationLevel: faker.helpers.arrayElement([
                            'Elementary',
                            'High School',
                            'College Graduate',
                            'Post Graduate',
                        ]),
                        philhealthNumber: faker.datatype.boolean()
                            ? faker.string.numeric(12)
                            : null,
                        nhtsStatus: faker.helpers.arrayElement([
                            'Active',
                            'Inactive',
                            'Graduated',
                            'Not Member',
                        ]),
                        personWithDisability: faker.datatype.boolean({
                            probability: 0.1,
                        }),
                        indigenousPeople: faker.datatype.boolean({
                            probability: 0.05,
                        }),
                    },
                },
            },
        });

        await wait(50);
    }
}

//? ====================================== MEDICAL RECORDS ====================================== ?//

async function createMedicalRecords() {
    console.log('Creating medical records and health data...');

    const userProfiles = await prisma.userProfile.findMany({
        include: { account: true },
    });

    for (const profile of userProfiles) {
        if (profile.account.role === 'USER') {
            // Create Family Record (only for some users to avoid too many families)
            if (faker.datatype.boolean({ probability: 0.4 })) {
                const familyRecord = await prisma.familyRecord.create({
                    data: {
                        familyId: `FAM-${faker.string
                            .alphanumeric(8)
                            .toUpperCase()}`,
                        headOfFamilyId: profile.id,
                        address: profile.address,
                        contactNumber: profile.contactNumber,
                        smsConsent: faker.datatype.boolean({
                            probability: 0.7,
                        }),
                    },
                });

                // Create some family members for this family
                const memberCount = faker.number.int({ min: 1, max: 5 });
                for (let i = 0; i < memberCount; i++) {
                    await prisma.familyMember.create({
                        data: {
                            familyRecordId: familyRecord.id,
                            memberName: faker.person.fullName(),
                            relationship: faker.helpers.arrayElement([
                                'Spouse',
                                'Child',
                                'Parent',
                                'Sibling',
                                'Other',
                            ]),
                            gender:
                                faker.person.sexType() === 'male'
                                    ? 'Male'
                                    : 'Female',
                            age: faker.number.int({ min: 1, max: 80 }),
                            occupation: faker.datatype.boolean({
                                probability: 0.6,
                            })
                                ? faker.person.jobTitle()
                                : null,
                            civilStatus: faker.helpers.arrayElement([
                                'Single',
                                'Married',
                                'Widowed',
                                'Separated',
                            ]),
                        },
                    });
                }

                // Create Family Health History
                await prisma.familyHealthHistory.create({
                    data: {
                        familyRecordId: familyRecord.id,
                        geneticConditions: JSON.stringify(
                            faker.helpers.arrayElements(
                                [
                                    'Hypertension',
                                    'Diabetes',
                                    'Heart Disease',
                                    'Cancer',
                                    'Asthma',
                                    'None',
                                ],
                                { min: 1, max: 3 }
                            )
                        ),
                        chronicDiseases: JSON.stringify(
                            faker.helpers.arrayElements(
                                [
                                    'Diabetes',
                                    'Hypertension',
                                    'Heart Disease',
                                    'Kidney Disease',
                                    'None',
                                ],
                                { min: 1, max: 2 }
                            )
                        ),
                        recordedBy: faker.person.fullName(),
                    },
                });
            }

            // Create Health Records - using various health monitoring models

            // Create Vital Signs
            await prisma.vitalSigns.create({
                data: {
                    userProfileId: profile.id,
                    recordDate: faker.date.recent({ days: 30 }),
                    bloodPressure: `${faker.number.int({
                        min: 90,
                        max: 160,
                    })}/${faker.number.int({ min: 60, max: 100 })}`,
                    heartRate: faker.number.int({ min: 60, max: 100 }),
                    respiratoryRate: faker.number.int({ min: 12, max: 20 }),
                    temperatureCelsius: faker.number.float({
                        min: 36.0,
                        max: 37.5,
                        fractionDigits: 1,
                    }),
                    pulseRate: faker.number.int({ min: 60, max: 100 }),
                    recordedBy: faker.person.fullName(),
                },
            });

            // Create Anthropometric Measurements
            await prisma.anthropometricMeasurement.create({
                data: {
                    userProfileId: profile.id,
                    measurementDate: faker.date.recent({ days: 60 }),
                    weightKg: faker.number.float({
                        min: 40,
                        max: 120,
                        fractionDigits: 1,
                    }),
                    heightCm: faker.number.float({
                        min: 150,
                        max: 200,
                        fractionDigits: 1,
                    }),
                    headCircumferenceCm:
                        profile.age < 5
                            ? faker.number.float({
                                  min: 30,
                                  max: 55,
                                  fractionDigits: 1,
                              })
                            : null,
                    waistCircumferenceCm: faker.number.float({
                        min: 60,
                        max: 120,
                        fractionDigits: 1,
                    }),
                    bmi: faker.number.float({
                        min: 16,
                        max: 35,
                        fractionDigits: 1,
                    }),
                    recordedBy: faker.person.fullName(),
                },
            });

            // Create NCD Risk Assessment (for adults)
            if (profile.age >= 18) {
                await prisma.nCDRiskAssessment.create({
                    data: {
                        userProfileId: profile.id,
                        assessmentDate: faker.date.recent({ days: 90 }),
                        smokingStatus: faker.helpers.arrayElement([
                            'Never',
                            'Former',
                            'Current',
                            'Unknown',
                        ]),
                        alcoholIntake: faker.helpers.arrayElement([
                            'None',
                            'Occasional',
                            'Regular',
                            'Heavy',
                        ]),
                        physicalActivity: faker.helpers.arrayElement([
                            'Low',
                            'Moderate',
                            'High',
                        ]),
                        fruitVegetableIntake: faker.helpers.arrayElement([
                            'Low',
                            'Adequate',
                            'High',
                        ]),
                        familyHistoryDiabetes: faker.datatype.boolean({
                            probability: 0.2,
                        }),
                        familyHistoryHypertension: faker.datatype.boolean({
                            probability: 0.3,
                        }),
                        familyHistoryHeartDisease: faker.datatype.boolean({
                            probability: 0.15,
                        }),
                        familyHistoryStroke: faker.datatype.boolean({
                            probability: 0.1,
                        }),
                        screeningCompleted: faker.datatype.boolean({
                            probability: 0.7,
                        }),
                        followUpNeeded: faker.datatype.boolean({
                            probability: 0.4,
                        }),
                        lifestyleModifications: JSON.stringify(
                            faker.helpers.arrayElements(
                                [
                                    'Quit smoking',
                                    'Reduce alcohol intake',
                                    'Increase physical activity',
                                    'Improve diet',
                                    'Weight management',
                                    'Stress management',
                                ],
                                { min: 0, max: 3 }
                            )
                        ),
                        healthEducationReceived: JSON.stringify(
                            faker.helpers.arrayElements(
                                [
                                    'Nutrition counseling',
                                    'Exercise guidance',
                                    'Disease prevention',
                                    'Medication compliance',
                                    'Lifestyle changes',
                                ],
                                { min: 0, max: 2 }
                            )
                        ),
                        recordedBy: faker.person.fullName(),
                    },
                });
            }

            // Create some Maternal Health Records (for women of childbearing age)
            if (
                profile.gender === 'Female' &&
                profile.age >= 15 &&
                profile.age <= 49 &&
                faker.datatype.boolean({ probability: 0.3 })
            ) {
                const maternalHealth = await prisma.maternalHealth.create({
                    data: {
                        userProfileId: profile.id,
                        mothersName: profile.fullName,
                        mothersAge: profile.age,
                        mothersBirthday: profile.dateOfBirth,
                        mothersMaidenName: faker.person.lastName(),
                        mothersReligion: profile.religion,
                        mothersEducation: profile.educationLevel,
                        mothersOccupation: profile.occupation,
                        numberOfChildren: faker.number.int({ min: 0, max: 5 }),
                        gravidaPara: `G${faker.number.int({
                            min: 1,
                            max: 6,
                        })}P${faker.number.int({ min: 0, max: 5 })}`,
                        menarcheAge: faker.number.int({ min: 10, max: 16 }),
                        lastMenstrualPeriod: faker.date.recent({ days: 300 }),
                        expectedDeliveryDate: faker.date.future({ years: 1 }),
                        tetanusToxoidStatus: faker.helpers.arrayElement([
                            'TT1',
                            'TT2',
                            'TT3',
                            'Complete',
                            'None',
                        ]),
                    },
                });

                // Create some prenatal visits
                const visitCount = faker.number.int({ min: 1, max: 4 });
                for (let v = 0; v < visitCount; v++) {
                    await prisma.prenatalVisit.create({
                        data: {
                            maternalHealthId: maternalHealth.id,
                            visitDate: faker.date.recent({ days: 180 }),
                            gestationalAgeWeeks: faker.number.int({
                                min: 8,
                                max: 40,
                            }),
                            weightKg: faker.number.float({
                                min: 45,
                                max: 80,
                                fractionDigits: 1,
                            }),
                            heightCm: faker.number.float({
                                min: 150,
                                max: 170,
                                fractionDigits: 1,
                            }),
                            bloodPressure: `${faker.number.int({
                                min: 90,
                                max: 140,
                            })}/${faker.number.int({ min: 60, max: 90 })}`,
                            fundalHeightCm: faker.number.float({
                                min: 10,
                                max: 40,
                                fractionDigits: 1,
                            }),
                            fetalHeartTone: `${faker.number.int({
                                min: 120,
                                max: 160,
                            })} bpm`,
                            nextVisitDate: faker.datatype.boolean({
                                probability: 0.8,
                            })
                                ? faker.date.future({ days: 30 })
                                : null,
                            recordedBy: faker.person.fullName(),
                        },
                    });
                }
            }

            // Create Child Health Records (for children under 18)
            if (profile.age < 18) {
                // Create Birth Information
                await prisma.birthInformation.create({
                    data: {
                        userProfileId: profile.id,
                        maternalHealthId: null, // We'd need to link this properly in a real scenario
                        placeOfDelivery: faker.helpers.arrayElement([
                            'Hospital',
                            'Birthing Center',
                            'Home',
                            'Health Center',
                        ]),
                        timeOfDelivery: faker.date
                            .past({ years: profile.age })
                            .toTimeString()
                            .slice(0, 5),
                        deliveryType: faker.helpers.arrayElement([
                            'Normal',
                            'Cesarean',
                        ]),
                        birthWeightKg: faker.number.float({
                            min: 2.5,
                            max: 4.5,
                            fractionDigits: 2,
                        }),
                        birthHeightCm: faker.number.float({
                            min: 45,
                            max: 55,
                            fractionDigits: 1,
                        }),
                        newbornScreeningDate: faker.datatype.boolean({
                            probability: 0.8,
                        })
                            ? faker.date.past({ years: profile.age })
                            : null,
                        newbornScreeningCompleted: faker.datatype.boolean({
                            probability: 0.8,
                        }),
                        feedingType: faker.helpers.arrayElement([
                            'Breastfeeding',
                            'Formula',
                            'Mixed',
                        ]),
                        recordedBy: faker.person.fullName(),
                    },
                });

                // Create Growth Tracking (for children under 5)
                if (profile.age < 5) {
                    await prisma.growthTracking.create({
                        data: {
                            userProfileId: profile.id,
                            trackingDate: faker.date.recent({ days: 90 }),
                            weightForAge: faker.helpers.arrayElement([
                                'Normal',
                                'Underweight',
                                'Overweight',
                            ]),
                            heightForAge: faker.helpers.arrayElement([
                                'Normal',
                                'Stunted',
                                'Tall',
                            ]),
                            weightForHeight: faker.helpers.arrayElement([
                                'Normal',
                                'Wasted',
                                'Overweight',
                            ]),
                            recordedBy: faker.person.fullName(),
                        },
                    });
                }

                // Create Immunization Events for children
                if (profile.age < 12) {
                    const immunizationEvent =
                        await prisma.immunizationEvent.create({
                            data: {
                                userProfileId: profile.id,
                                visitDate: faker.date.recent({ days: 180 }),
                                temperatureCelsius: faker.number.float({
                                    min: 36.0,
                                    max: 37.2,
                                    fractionDigits: 1,
                                }),
                                weightKg: faker.number.float({
                                    min: profile.age * 2 + 8,
                                    max: profile.age * 3 + 15,
                                    fractionDigits: 1,
                                }),
                                heightCm: faker.number.float({
                                    min: profile.age * 6 + 50,
                                    max: profile.age * 7 + 70,
                                    fractionDigits: 1,
                                }),
                                adverseReactions: faker.datatype.boolean({
                                    probability: 0.1,
                                })
                                    ? faker.helpers.arrayElement([
                                          'Mild fever',
                                          'Redness at injection site',
                                          'Fussiness',
                                      ])
                                    : null,
                                healthWorkerName: faker.person.fullName(),
                                healthWorkerSignature: null,
                                nextFollowupDate: faker.date.future({
                                    days: 60,
                                }),
                                recordedBy: faker.person.fullName(),
                            },
                        });

                    // Add some vaccines given
                    const vaccines = [
                        'BCG',
                        'Hepatitis B',
                        'DPT',
                        'OPV',
                        'MMR',
                    ];
                    const vaccineCount = faker.number.int({ min: 1, max: 3 });
                    const selectedVaccines = faker.helpers.arrayElements(
                        vaccines,
                        vaccineCount
                    );

                    for (const vaccine of selectedVaccines) {
                        await prisma.vaccineGiven.create({
                            data: {
                                immunizationEventId: immunizationEvent.id,
                                vaccineName: vaccine,
                                doseNumber: faker.helpers.arrayElement([
                                    '1st',
                                    '2nd',
                                    '3rd',
                                    'Booster',
                                ]),
                                dateGiven: immunizationEvent.visitDate,
                                lotNumber: faker.string
                                    .alphanumeric(8)
                                    .toUpperCase(),
                            },
                        });
                    }
                }
            }

            await wait(100);
        }
    }
}

//? ===================================== HEALTH SERVICES ===================================== ?//

async function createHealthServices() {
    console.log('Creating health services and appointments...');

    const userProfiles = await prisma.userProfile.findMany({
        where: { account: { role: 'USER' } },
        include: { account: true },
    });

    const healthWorkers = await prisma.healthWorker.findMany();
    const accounts = await prisma.account.findMany({
        where: { role: { in: ['HEALTH_WORKER', 'SUPER_ADMIN'] } },
    });

    // Create Visit Records
    for (let i = 0; i < 100; i++) {
        const userProfile = faker.helpers.arrayElement(userProfiles);

        await prisma.visitRecord.create({
            data: {
                userProfileId: userProfile.id,
                visitDate: faker.date.recent({ days: 90 }),
                visitType: faker.helpers.arrayElement([
                    'Prenatal Care',
                    'Postnatal Care',
                    'Child Immunization',
                    'Family Planning',
                    'General Consultation',
                    'Emergency',
                ]),
                visitFrequency: faker.helpers.arrayElement([
                    'First Visit',
                    'Follow-up',
                    'Regular',
                ]),
                referred: faker.datatype.boolean({ probability: 0.2 }),
                facilityName: faker.datatype.boolean({ probability: 0.2 })
                    ? faker.helpers.arrayElement([
                          'City Health Center',
                          'Barangay Health Station',
                          'District Hospital',
                      ])
                    : null,
                referralReason: faker.datatype.boolean({ probability: 0.2 })
                    ? faker.helpers.arrayElement([
                          'Specialist Care',
                          'Laboratory Tests',
                          'Advanced Treatment',
                      ])
                    : null,
                recordedBy: faker.helpers.arrayElement(healthWorkers).name,
            },
        });
    }

    // Create Health Education Records
    for (let i = 0; i < 80; i++) {
        const userProfile = faker.helpers.arrayElement(userProfiles);

        await prisma.healthEducation.create({
            data: {
                userProfileId: userProfile.id,
                topicsCovered: JSON.stringify(
                    faker.helpers.arrayElements(
                        [
                            'Family Planning',
                            'Maternal Health',
                            'Child Care',
                            'Nutrition',
                            'Disease Prevention',
                            'Hygiene',
                        ],
                        { min: 1, max: 3 }
                    )
                ),
                dateProvided: faker.date.recent({ days: 60 }),
                providedBy: faker.helpers.arrayElement(healthWorkers).name,
            },
        });
    }

    // Create Virtual Checkups
    for (let i = 0; i < 30; i++) {
        const userProfile = faker.helpers.arrayElement(userProfiles);
        const healthWorker = faker.helpers.arrayElement(healthWorkers);

        await prisma.virtualCheckup.create({
            data: {
                userProfileId: userProfile.id,
                healthWorkerId: healthWorker.id,
                scheduledDate: faker.date.future({ days: 30 }),
                scheduledTime: faker.helpers.arrayElement([
                    '09:00',
                    '10:00',
                    '11:00',
                    '14:00',
                    '15:00',
                    '16:00',
                ]),
                meetingUrl: `https://meet.predictimed.com/room-${faker.string.alphanumeric(
                    8
                )}`,
                status: faker.helpers.arrayElement([
                    'Scheduled',
                    'Completed',
                    'Cancelled',
                    'No Show',
                ]),
                consultationType: faker.helpers.arrayElement([
                    'Follow-up',
                    'Initial Consultation',
                    'Prescription Renewal',
                ]),
                chiefComplaint: faker.lorem.sentence(),
                notes: faker.lorem.words(10), // Using only 10 words to keep it short
                durationMinutes: faker.number.int({ min: 15, max: 60 }),
            },
        });
    }

    // Create Appointments
    for (let i = 0; i < 150; i++) {
        const userProfile = faker.helpers.arrayElement(userProfiles);

        await prisma.appointment.create({
            data: {
                userProfileId: userProfile.id,
                nextVisitDate: faker.date.future({ days: 90 }),
                visitType: faker.helpers.arrayElement([
                    'Prenatal Check-up',
                    'Child Immunization',
                    'Follow-up Consultation',
                    'Family Planning',
                    'Health Screening',
                ]),
                appointmentStatus: faker.helpers.arrayElement([
                    'Scheduled',
                    'Confirmed',
                    'Completed',
                    'Cancelled',
                    'Rescheduled',
                ]),
                scheduledBy: faker.helpers.arrayElement(healthWorkers).name,
            },
        });
    }

    // Create Medical Programs
    const programs = [
        'Expanded Program on Immunization (EPI)',
        'Maternal and Child Health Program',
        'Family Planning Program',
        'Nutrition Program',
        'Tuberculosis Control Program',
    ];

    for (const programName of programs) {
        await prisma.medicalProgram.create({
            data: {
                programName: programName,
                description: `${programName} implementation for community health improvement`,
                programType: faker.helpers.arrayElement([
                    'Health Promotion',
                    'Disease Prevention',
                    'Treatment Program',
                ]),
                startDate: faker.date.past({ years: 2 }),
                endDate: faker.date.future({ years: 2 }),
                venue: faker.helpers.arrayElement([
                    'Community Health Center',
                    'Barangay Hall',
                    'School',
                    'Health Station',
                ]),
                targetDemographic: faker.helpers.arrayElement([
                    'All Ages',
                    'Women',
                    'Children',
                    'Elderly',
                    'Pregnant Women',
                ]),
                targetParticipants: faker.number.int({ min: 50, max: 500 }),
                status: faker.helpers.arrayElement([
                    'Active',
                    'Planning',
                    'Completed',
                ]),
                bannerImageUrl: null,
                createdBy: faker.helpers.arrayElement(accounts).id,
            },
        });
    }
}

//? ===================================== EVENTS & PROGRAMS ===================================== ?//

async function createEventsAndPrograms() {
    console.log('Creating events and communication programs...');

    const accounts = await prisma.account.findMany({
        where: { role: { in: ['HEALTH_WORKER', 'SUPER_ADMIN'] } },
    });

    const userProfiles = await prisma.userProfile.findMany({ take: 30 });

    // Create Events
    for (let i = 0; i < 20; i++) {
        const eventTypes = [
            'Health Education',
            'Vaccination Drive',
            'Medical Mission',
            'Training',
        ];
        const eventType = faker.helpers.arrayElement(eventTypes);

        await prisma.event.create({
            data: {
                title: `${eventType} - ${faker.location.city()}`,
                description: `Community ${eventType.toLowerCase()} program`,
                eventType: eventType,
                eventDate: faker.date.future({ years: 1 }),
                startTime: faker.helpers.arrayElement([
                    '08:00',
                    '09:00',
                    '10:00',
                    '14:00',
                ]),
                endTime: faker.helpers.arrayElement([
                    '12:00',
                    '15:00',
                    '16:00',
                    '17:00',
                ]),
                venue: faker.location.streetAddress(),
                targetAudience: faker.helpers.arrayElement([
                    'General Public',
                    'Pregnant Women',
                    'Children',
                    'Health Workers',
                ]),
                maxParticipants: faker.number.int({ min: 50, max: 500 }),
                status: faker.helpers.arrayElement([
                    'Planned',
                    'Ongoing',
                    'Completed',
                    'Cancelled',
                ]),
                bannerImageUrl: null,
                createdBy: faker.helpers.arrayElement(accounts).id,
            },
        });
    }

    // Create Surveys
    for (let i = 0; i < 10; i++) {
        const surveyTopics = [
            'Health Status',
            'Service Satisfaction',
            'Program Feedback',
            'Community Needs',
        ];
        const topic = faker.helpers.arrayElement(surveyTopics);

        const survey = await prisma.survey.create({
            data: {
                title: `${topic} Survey ${i + 1}`,
                description: `Assessment of ${topic.toLowerCase()} in the community`,
                surveyType: faker.helpers.arrayElement([
                    'Health Status',
                    'Satisfaction',
                    'Needs Assessment',
                ]),
                isActive: faker.datatype.boolean({ probability: 0.8 }),
                startDate: faker.date.recent({ days: 90 }),
                endDate: faker.date.future({ days: 30 }),
                qrCode: `QR-${faker.string.alphanumeric(8).toUpperCase()}`,
                createdBy: faker.helpers.arrayElement(accounts).id,
            },
        });

        // Create survey questions
        const questionTexts = [
            'How would you rate your overall health?',
            'What health services do you need most?',
            'Any additional comments?',
        ];

        for (let j = 0; j < questionTexts.length; j++) {
            const question = await prisma.surveyQuestion.create({
                data: {
                    surveyId: survey.id,
                    questionText: questionTexts[j],
                    questionType:
                        j === 0
                            ? 'rating'
                            : j === 1
                            ? 'multiple_choice'
                            : 'text',
                    options:
                        j === 1
                            ? JSON.stringify([
                                  'Primary Care',
                                  'Emergency Care',
                                  'Specialist Care',
                              ])
                            : JSON.stringify([]),
                    isRequired: j < 2,
                    orderIndex: j + 1,
                },
            });
        }

        // Create some survey responses
        const respondents = faker.helpers.arrayElements(userProfiles, {
            min: 5,
            max: 15,
        });

        for (const respondent of respondents) {
            const surveyResponse = await prisma.surveyResponse.create({
                data: {
                    surveyId: survey.id,
                    userProfileId: respondent.id,
                    ipAddress: faker.internet.ip(),
                },
            });

            // Create answers for each question
            const questions = await prisma.surveyQuestion.findMany({
                where: { surveyId: survey.id },
            });

            for (const question of questions) {
                let answer;
                if (question.questionType === 'rating') {
                    answer = faker.number.int({ min: 1, max: 5 }).toString();
                } else if (question.questionType === 'multiple_choice') {
                    answer = faker.helpers.arrayElement([
                        'Primary Care',
                        'Emergency Care',
                        'Specialist Care',
                    ]);
                } else {
                    answer = faker.lorem.sentence();
                }

                await prisma.surveyAnswer.create({
                    data: {
                        surveyResponseId: surveyResponse.id,
                        surveyQuestionId: question.id,
                        answer: answer,
                    },
                });
            }
        }
    }
}

//? ===================================== SYSTEM DATA ===================================== ?//

async function createSystemData() {
    console.log('Creating system analytics and logs...');

    const accounts = await prisma.account.findMany();

    // Create Analytics Reports
    for (let i = 0; i < 15; i++) {
        const reportType = faker.helpers.arrayElement([
            'Population Health',
            'Service Statistics',
            'Program Evaluation',
        ]);

        await prisma.analyticsReport.create({
            data: {
                reportName: `${reportType} Report ${i + 1}`,
                reportType: reportType,
                dataFilters: JSON.stringify([
                    'dateRange:2024-01-01-2024-12-31',
                    'location:All Barangays',
                    'ageGroup:All Ages',
                ]),
                reportData: JSON.stringify({
                    totalRecords: faker.number.int({ min: 100, max: 1000 }),
                    keyMetrics: {
                        coverage: faker.number.float({
                            min: 0.5,
                            max: 1,
                            fractionDigits: 2,
                        }),
                        satisfaction: faker.number.float({
                            min: 3,
                            max: 5,
                            fractionDigits: 1,
                        }),
                    },
                    trends: {
                        monthly: Array.from({ length: 12 }, () =>
                            faker.number.int({ min: 50, max: 200 })
                        ),
                    },
                }),
                reportPeriodStart: faker.date.past({ years: 1 }),
                reportPeriodEnd: faker.date.recent({ days: 30 }),
                generatedBy: faker.helpers.arrayElement(accounts).id,
            },
        });
    }

    // Create Prediction Models
    for (let i = 0; i < 5; i++) {
        const modelTypes = [
            'Disease Outbreak',
            'Service Demand',
            'Population Growth',
        ];
        const modelType = faker.helpers.arrayElement(modelTypes);

        await prisma.predictionModel.create({
            data: {
                modelName: `${modelType} Prediction Model`,
                modelType: faker.helpers.arrayElement([
                    'Classification',
                    'Regression',
                    'Time Series',
                ]),
                modelParameters: JSON.stringify({
                    algorithm: faker.helpers.arrayElement([
                        'Linear Regression',
                        'Random Forest',
                        'Neural Network',
                    ]),
                    learning_rate: 0.01,
                    epochs: 100,
                    batch_size: 32,
                    features: faker.number.int({ min: 5, max: 20 }),
                }),
                predictionResults: JSON.stringify({
                    predictions: Array.from({ length: 10 }, () =>
                        faker.number.float({
                            min: 0,
                            max: 1,
                            fractionDigits: 3,
                        })
                    ),
                    confidence: faker.number.float({
                        min: 0.8,
                        max: 0.99,
                        fractionDigits: 3,
                    }),
                }),
                accuracy: faker.number.float({
                    min: 0.7,
                    max: 0.95,
                    fractionDigits: 3,
                }),
                lastTrained: faker.date.recent({ days: 7 }),
                isActive: faker.datatype.boolean({ probability: 0.8 }),
                createdBy: faker.helpers.arrayElement(accounts).id,
            },
        });
    }

    // Create System Logs
    const logActions = [
        'User Login',
        'User Logout',
        'Data Created',
        'Data Updated',
        'Data Deleted',
        'Report Generated',
        'Backup Created',
        'System Error',
    ];

    const entityTypes = [
        'Account',
        'UserProfile',
        'HealthRecord',
        'Event',
        'Survey',
    ];

    for (let i = 0; i < 200; i++) {
        const action = faker.helpers.arrayElement(logActions);
        const entityType = faker.helpers.arrayElement(entityTypes);

        await prisma.systemLog.create({
            data: {
                userId: faker.helpers.arrayElement(accounts).id,
                action: action,
                entityType: entityType,
                entityId: faker.string.alphanumeric(25), // Using alphanumeric instead of cuid
                oldData:
                    action.includes('Updated') || action.includes('Deleted')
                        ? JSON.stringify({ previousValue: faker.lorem.word() })
                        : null,
                newData:
                    action.includes('Created') || action.includes('Updated')
                        ? JSON.stringify({ newValue: faker.lorem.word() })
                        : null,
                ipAddress: faker.internet.ip(),
                userAgent: faker.internet.userAgent(),
            },
        });

        if (i % 50 === 0) await wait(100);
    }
}

//? ====================================== EXECUTE SEEDS ====================================== ?//

async function main() {
    try {
        console.log('🌱 Starting database seeding...');

        await createAccounts();
        console.log('✅ Accounts created successfully.');

        await createMedicalRecords();
        console.log('✅ Medical records created successfully.');

        await createHealthServices();
        console.log('✅ Health services created successfully.');

        await createEventsAndPrograms();
        console.log('✅ Events and programs created successfully.');

        await createSystemData();
        console.log('✅ System data created successfully.');

        console.log('🎉 Database seeding completed successfully!');
    } catch (error) {
        console.error('❌ Error seeding data:', error);
        process.exit(1);
    } finally {
        await prisma.$disconnect();
    }
}

main();
