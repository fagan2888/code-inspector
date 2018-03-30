package goisbn

import "testing"

func Test(t *testing.T) {
	//var tests  map[string]string

	//tests = make(map[string]string)

	// this token from https://github.com/JNRowe/pyisbn/blob/master/tests/test_data.py
	tests := map[string]string{"20, 000 Twenty Thousand Leagues Under the Sea": "0-14-062118-0",
		"3D Math Primer for Graphics and Game Development":                                         "1-55622-911-9",
		"A Course in Combinatorics":                                                                "0-521-00601-5",
		"A Course in Modern Mathematical Physics: Groups, Hilbert Space and Differential Geometry": "0-521-82960-7",
		"A First Course in Coding Theory (Oxford Applied Mathematics & Computing Science S.)":      "0-19-853803-0",
		"A First Course in General Relativity":                                                     "0-521-27703-5",
		"A First Course in String Theory":                                                          "0-521-83143-1",
		"A New Kind of Science":                                                                    "1-57955-008-8",
		"ADA in Distributed Real Time Systems":                                                     "0-07-046544-4",
		"Ada 2005 Reference Manual":                                                                "3-540-69335-1",
		"Advanced Engineering Mathematics":                                                         "1-4039-0312-3",
		"Advanced Signal Processing Algorithms, Architectures, and Implementation IX (SPIE)":       "0-8194-3293-8",
		"Aerodynamics for Engineering Students":                                                    "0-7506-5111-3",
		"Aerospace Avionics Systems: A Modern Synthesis":                                           "978-0-12-646890-8",
		"An Introduction to Fire Dynamics":                                                         "0-471-97291-6",
		"An Introduction to Modern Astrophysics (International Edition)":                           "0-321-21030-1",
		"An Introduction to Radio Astronomy":                                                       "0-521-00517-5",
		"Antenna Arraying Techniques in the Deep Space Network":                                    "0-471-46799-5",
		"Applied Combinatorics":                                                                    "0-471-43809-X",
		"Applied Cryptography: Protocols, Algorithms and Source Code in C":                         "0-471-11709-9",
		"Applied Satellite Navigation Using GPS, GALILEO, and Augmentation Systems":                "1-58053-814-2",
		"Archimedes Effect":                                                                        "0-14-101143-2",
		"Artificial Intelligence: A Modern Approach (International Edition)":                       "0-13-080302-2",
		"Artificial Intelligence: Structures and Strategies for Complex Problem Solving":           "0-321-26318-9",
		"Astronomical Algorithms":                                                                  "0-943396-61-1",
		"At the Bench: A Laboratory Navigator":                                                     "0-87969-708-3",
		"Automatic Target Recognition IX (SPIE)":                                                   "0-8194-3192-3",
		"Autonomous Software-defined Radio Receivers for Deep Space Applications":                  "0-470-08212-7",
		"Avionics Troubleshooting and Repair":                                                      "978-0-07-136495-9",
		"Beyond Fear: Thinking Sensibly About Security in an Uncertain World":                      "0-387-02620-7",
		"Brunel: The Man Who Built the World":                                                      "0-297-84408-3",
		"Burning Chrome":                                                                           "978-0-00-648043-3",
		"CFD: A Practical Approach":                                                                "0-7506-8563-8",
		"Carbon Fibers and Their Composites":                                                       "978-0-8247-0983-9",
		"Carrie": "978-0-385-08695-0",
		"Causality: Models, Reasoning, and Inference":                                         "0-521-77362-8",
		"Chaos: An Introduction to Dynamical Systems (Textbooks in Mathematical Sciences S.)": "0-387-94677-2",
		"Chaos and Complexity in Astrophysics":                                                "0-521-85534-9",
		"Civil Engineering Formulas":                                                          "0-07-135612-6",
		"Classical Mechanics: An Undergraduate Text":                                          "0-521-53409-7",
		"Clear and Present Danger":                                                            "0-00-617730-1",
		"Colossus: The Secrets of Bletchley Park's Code-breaking Computers":                   "0-19-284055-X",
		"Combinatorial Auctions":                                                              "0-262-03342-9",
		"Combinatorics: Topics, Techniques, Algorithms":                                       "0-521-45761-0",
		"Computational Fluid Dynamics":                                                        "0-521-76969-8",
		"Count Zero":                                                                          "0-575-03696-6",
		"Creating More Effective Graphs":                                                      "0-471-27402-X",
		"Crime Scene Investigation: Methods and Procedures":                                   "0-335-21490-8",
		"Crime Scene to Court: The Essentials of Forensic Science":                            "0-85404-656-9",
		"Criminalistics: An Introduction to Forensic Science":                                 "0-13-122889-7",
		"Cryptography Theory and Practice":                                                    "1-58488-508-4",
		"Cryptonomicon":                                                                       "978-0-09-941067-6",
		"Cybernetics: Or Control and Communication in the Animal and the Machine":    "0-262-73009-X",
		"Cyberpunk and Cyberculture: Science Fiction and the Work of William Gibson": "0-485-00607-3",
		"Data Analysis: A Bayesian Tutorial":                                         "0-19-856832-0",
		"Dead Reckoning: Calculating Without Instruments":                            "0-88415-087-9",
		"Deep Down Things: The Breathtaking Beauty of Particle Physics":              "0-8018-7971-X",
		"Democratizing Innovation":                                                   "0-262-00274-4",
		"Dependence Logic: A New Approach to Independence Friendly Logic":            "0-521-70015-9",
		"Design patterns : elements of reusable object-oriented software":            "0-201-63361-2",
		"Dictionary of British Sign Language":                                        "0-571-14346-6",
		"Discovering Genomics, Proteomics and Bioinformatics":                        "0-8053-8219-4",
		"Discovering Statistics Using SPSS":                                          "0-7619-4452-4",
		"Divine Comedy":                                                              "978-0-631-12926-4",
		"Don Quixote":                                                                "978-1-85326-036-0",
		"Dracula":                                                                    "978-0-19-956409-5",
		"Einstein's Miraculous Year: Five Papers That Changed the Face of Physics": "0-691-12228-8",
		"Electronic Navigation Systems":                                            "978-0-7506-5138-7",
		"Elements of Photogrammetry with Applications in GIS":                      "0-07-292454-3",
		"Engineering Mathematics 5th ed":                                           "0-333-91939-4",
		"Essential Computational Fluid Dynamics":                                   "0-470-42329-3",
		"Estimation with Applications to Tracking and Navigation":                  "0-471-41655-X",
		"Evolution of Networks: From Biological Nets to the Internet and WWW":      "0-19-851590-1",
		"Factory Physics":                                                                                                                "0-07-116378-6",
		"Forensic Science":                                                                                                               "0-13-043251-2",
		"Friendly Introduction to Graph Theory":                                                                                          "0-13-066949-0",
		"From the Earth to the Moon":                                                                                                     "0-553-21420-9",
		"Fundamentals of Biomechanics":                                                                                                   "0-306-47474-3",
		"Fundamentals of Heat and Mass Transfer":                                                                                         "0-471-38650-2",
		"Fundamentals of the Physical Environment":                                                                                       "0-415-23294-5",
		"Gauge Theories in Particle Physics: From Relativistic Quantum Mechanics to QED: v. 1":                                           "0-7503-0864-8",
		"Generalized Latent Variable Modeling: Multilevel, Longitudinal, & Structural Equation Models":                                   "1-58488-000-7",
		"Generating Families in the Restricted Three-Body Problem (Lecture Notes in Physics S.)":                                         "3-540-63802-4",
		"Generating Families in the Restricted Three-body Problem: Quantitative Study of Bifurcations: Pt. 2 (Lecture Notes in Physics)": "3-540-41733-8",
		"Genetic Algorithms in Search, Optimization and Machine Learning":                                                                "0-201-15767-5",
		"Getting Things Done: The Art of Stress-Free Productivity":                                                                       "0-670-88906-7",
		"Global Navigation Satellite System (GNSS) Receivers for Weak Signals":                                                           "1-59693-052-7",
		"Global Positioning System: Theory and Applications":                                                                             "978-1-56347-107-0",
		"Gonzo Gizmos: Projects and Devices to Channel Your Inner Geek":                                                                  "1-55652-520-6",
		"Gravity from the Ground Up: An Introductory Guide to Gravity and General Relativity":                                            "0-521-45506-5",
		"Ground Penetrating Radar":                                                                                                       "0-86341-360-9",
		"Guide to Biometrics (Springer Professional Computing S.)":                                                                       "0-387-40089-3",
		"Guide to Elliptic Curve Cryptography (Springer Professional Computing)":                                                         "0-387-95273-X",
		"Hackers and Painters: Essays on the Art of Programming":                                                                         "0-596-00662-4",
		"Hacking GPS":                                                              "0-7645-8424-3",
		"Handbook of Applied Cryptography":                                         "0-8493-8523-7",
		"Handbook of Fingerprint Recognition (Springer Professional Computing S.)": "0-387-95431-7",
		"Heat and Mass Transfer":                                                   "1-904798-47-0",
		"Heat and Thermodynamics":                                                  "0-07-114816-7",
		"High Integrity Software":                                                  "0-321-13616-0",
		"How to Research":                                                          "0-335-20903-3",
		"How to Use a Computerized Telescope: Practical Amateur Astronomy Volume 1: v. 1 (Practical Amateur Astronomy)": "0-521-00790-9",
		"IA-64 Linux Kernel: Design and Implementation":                                                                 "0-13-061014-3",
		"Icon Steve Jobs: The Greatest Second Act in the History of Business":                                           "0-471-72083-6",
		"In Search of Dark Matter: The Search for Dark Matter in the Universe (Springer-Praxis Books S.)":               "0-387-27616-5",
		"Information and Coding Theory (Springer Undergraduate Mathematics S.)":                                         "1-85233-622-6",
		"Introduction to Algorithms":                                                                                    "0-262-53196-8",
		"Introduction to Elementary Particles":                                                                          "0-471-60386-4",
		"Introduction to Mechanics":                                                                                     "0-07-085423-8",
		"Introduction to Quantum Computation and Information":                                                           "981-02-4410-X",
		"Introduction to Space Physics (Cambridge Atmospheric & Space Science S.)":                                      "0-521-45714-9",
		"Introduction to Statistical Physics":                                                                           "0-7484-0942-4",
		"Isambard Kingdom Brunel":                                                                                       "0-14-011752-0",
		"Joel on Software: And on Diverse and Occasionally Related Matters That Will Prove of Interest to Software Developers, Designers, and Managers, and to Those Who, Whether by Good Fortune or Ill-Luck, Work with Them in Some Capacity": "1-59059-389-8",
		"Journey to the Centre of the Earth":                                                                               "0-14-062139-3",
		"Knots and Surfaces: A Guide to Discovering Mathematics":                                                           "0-8218-0451-0",
		"Knowledge Representation: Logical, Philosophical and Computational Foundations":                                   "0-534-94965-7",
		"LDAP in the Solaris Operating Environment: Deploying Secure Directory Services":                                   "0-13-145693-8",
		"Let's Sign Dictionary: Everyday BSL for Learners":                                                                 "0-9542384-3-5",
		"Linux Kernel Development":                                                                                         "0-672-32720-1",
		"Local Search in Combinatorial Optimization":                                                                       "0-691-11522-2",
		"Lunar and Planetary Webcam User's Guide (Patrick Moore's Practical Astronomy S.)":                                 "1-84628-197-0",
		"Malicious Cryptography: Exposing Cryptovirology":                                                                  "0-7645-4975-8",
		"Manual of Engineering Drawing":                                                                                    "0-7506-5120-2",
		"Mapping Hacks: Tips & Tools for Electronic Cartography":                                                           "978-0-596-00703-4",
		"Masters of Doom: How Two Guys Created an Empire and Transformed Pop Culture":                                      "0-7499-2489-6",
		"Mathematical Handbook for Scientists and Engineers: Definitions, Theorems, and Formulas for Reference and Review": "0-486-41147-8",
		"Mechanics (Course of Theoretical Physics)":                                                                        "0-7506-2896-0",
		"MicroC/OS II: The Real Time Kernel":                                                                               "1-57820-103-9",
		"Microfluidics for Biotechnology":                                                                                  "1-58053-961-0",
		"Microlight Pilot's Handbook":                                                                                      "978-1-84037-286-1",
		"Microsoft Application Architecture Guide v2":                                                                      "978-0-7356-2710-9",
		"Mobile Satellite Communications Handbook":                                                                         "978-0-471-29778-9",
		"Modern Supersymmetry: Dynamics and Duality (International Series of Monographs on Physics)":                       "0-19-856763-4",
		"Neuromancer":                                                                            "0-441-56956-0",
		"Mona Lisa Overdrive":                                                                    "978-0-00-648044-0",
		"Nonlinear Control Systems (Communications & Control Engineering S.)":                    "3-540-19916-0",
		"Nuclear and Particle Physics":                                                           "0-582-45088-8",
		"Numerical Heat Transfer and Fluid Flow":                                                 "0-89116-522-3",
		"Numerical Recipes in C++: The Art of Scientific Computing":                              "0-521-75033-4",
		"Paradigms of Artificial Intelligence Programming: Case Studies in Common LISP":          "1-55860-191-0",
		"Particle Astrophysics (Oxford Master Series in Physics)":                                "0-19-850952-9",
		"Particle Physics (Manchester Physics S.)":                                               "0-471-97285-1",
		"Pattern Recognition":                                                                    "978-0-241-95353-2",
		"Permutation City":                                                                       "1-85798-218-5",
		"Physical Design Essentials":                                                             "0-387-36642-3",
		"Power and Invention: Situating Science (Theory Out of Bounds S.)":                       "0-8166-2517-4",
		"Practical Statistics for Astronomers":                                                   "0-521-45616-9",
		"Predicting Motion: The Physical World (The Physical World)":                             "0-7503-0716-1",
		"Probabilistic Robotics (Intelligent Robotics & Autonomous Agents S.)":                   "0-262-20162-3",
		"Probability Theory: The Logic of Science: Principles and Elementary Applications Vol 1": "0-521-59271-2",
		"Programming and Customizing the Multicore Propeller Microcontroller":                    "978-0-07-166450-9",
		"Programming in Haskell":                                                                 "978-0-521-87172-3",
		"Quantum Groups: A Path to Current Algebra":                                              "0-521-69524-4",
		"Radiation Effects on Embedded System":                                                   "978-1-4020-5645-1",
		"Radiometric Tracking Techniques for Deep-Space Navigation":                              "0-471-44534-7",
		"Rainbow Six": "0-14-027405-7",
		"Ramsey Theory on the Integers (Student Mathematical Library)":                                          "0-8218-3199-2",
		"Random Graph Dynamics":                                                                                 "0-521-86656-1",
		"Reliable Embedded Systems":                                                                             "0-321-25291-8",
		"Reliable Software Technology":                                                                          "3-540-26286-5",
		"Renormalization Methods: A Guide for Beginners ":                                                       "0-19-850694-5",
		"Resilience Engineering: Concepts and Precepts":                                                         "0-7546-4904-0",
		"Revolutionaries of the Cosmos: The Astro-Physicists":                                                   "0-19-857099-6",
		"Schaum's Outline of Feedback and Control Systems (Schaum S.)":                                          "0-07-017052-5",
		"Secrets and Lies: Digital Security in a Networked World":                                               "0-471-45380-3",
		"Security Engineering: A Guide to Building Dependable Distributed Systems":                              "0-471-38922-6",
		"Sensor Modelling and Data Processing for Autonomous Navigation":                                        "981-02-3496-1",
		"Show Me the Numbers: Designing Tables and Graphs to Enlighten":                                         "0-9706019-9-9",
		"Signal Integrity Effects in Custom IC and ASIC Designs":                                                "0-471-15042-8",
		"Small Worlds: The Dynamics of Networks Between Order and Randomness (Princeton Studies in Complexity)": "0-691-11704-7",
		"Snow Crash": "978-0-241-95318-1",
		"Softwar: An Intimate Portrait of Larry Ellison and Oracle":                                                                       "0-7432-2505-8",
		"Software as Capital: Economic Perspective on Software Engineering":                                                               "0-8186-7779-1",
		"Solaris: Systems Programming":                                                                                                    "0-201-75039-2",
		"Spook Country":                                                                                                                   "978-0-241-95354-9",
		"Statistical Analysis of Circular Data":                                                                                           "0-521-56890-0",
		"Statistical Mechanics":                                                                                                           "9971-966-07-7",
		"Statistical Mechanics: A Survival Guide":                                                                                         "0-19-850816-6",
		"Statistical Mechanics: Entropy, Order Parameters and Complexity":                                                                 "0-19-856677-8",
		"Statistical Mechanics of Lattice Systems: Exact, Series and Renormalization Group Methods: v. 2 (Texts & Monographs in Physics)": "3-540-64436-9",
		"Statistics: An Introduction Using R":                                                                                             "0-470-02298-1",
		"Storming the Reality Studio: Casebook of Cyberpunk and Postmodern Science Fiction":                                               "0-8223-1168-2",
		"Strange Attractors: Chaos, Complexity and the Art of Family Therapy (Wiley Series in Couples & Family Dynamics & Treatment)":     "0-471-07951-0",
		"Strapdown Inertial Navigation Technology":                                                                                        "0-86341-358-7",
		"Swimsuit":                                "978-1-84605-262-0",
		"Synthesis of Arithmetic Circuits":        "0-471-68783-9",
		"Techniques of Crime Scene Investigation": "0-8493-1691-X",
		"The ASIC Handbook":                       "0-13-091558-0",
		"The Art of Intrusion: The Real Stories Behind the Exploits of Hackers, Intruders and Deceivers": "0-7645-6959-7",
		"The Art of Project Management":                                                                  "0-596-00786-8",
		"The Castle":                                                                                     "978-0-19-923828-6",
		"The Computational Beauty of Nature: Computer Explorations of Fractals, Chaos, Complex Systems and Adaptation (Bradford Book S.)": "0-262-56127-1",
		"The Concepts and Practice of Mathematical Finance (Mathematic, Finance & Risk S.)":                                               "0-521-82355-2",
		"The Damage Tolerance of Warp Knit Fabric Polymer Composites":                                                                     "978-3-639-23478-7",
		"The Difference Engine":                                                                                                           "0-575-04762-3",
		"The Economics of the European Patent System":                                                                                     "0-19-921698-3",
		"The Egyptian Calendar: A Work for Eternity":                                                                                      "1-902699-05-X",
		"The First Men in the Moon":                                                                                                       "0-460-87304-0",
		"The Girl with the Dragon Tattoo":                                                                                                 "978-1-84724-253-2",
		"The HP Way: How Bill Hewlett and I Built Our Company":                                                                            "0-06-084579-1",
		"The Hunt for Red October":                                                                                                        "0-00-617276-8",
		"The Idiot":                                                                                                                       "978-0-14-044792-7",
		"The International Standard Book Number System":                                  "3-88053-101-3",
		"The Invisible Man":                                                              "0-460-87628-7",
		"The Marine Electrical and Electronics Bible":                                    "978-1-57409-242-4",
		"The Meaning of It All (Allen Lane History S.)":                                  "0-14-027635-1",
		"The Mythical Man Month and Other Essays on Software Engineering":                "0-201-83595-9",
		"The Principia: Mathematical Principles of Natural Philosophy":                   "0-520-08817-4",
		"The Statistical Mechanics of Financial Markets (Texts & Monographs in Physics)": "3-540-00978-7",
		"The Thermodynamics Problem Solver":                                              "0-87891-555-9",
		"The Time Machine":                                                               "0-460-87735-6",
		"The Tipping Point":                                                              "0-316-31696-2",
		"The Trial":                                                                      "978-0-14-118290-2",
		"The Trouble with Physics":                                                       "0-7139-9799-0",
		"The Universal Computer: The Road from Leibniz to Turing":                        "0-393-04785-7",
		"The Visual Display of Quantitative Information":                                 "0-9613921-4-2",
		"The War of the Worlds":                                                          "0-460-87303-2",
		"Theory of Financial Risk and Derivative Pricing: From Statistical Physics to Risk Management": "0-521-81916-4",
		"Thermal Physics":                                                                                                                                         "0-521-65838-1",
		"Thermodynamics of Natural Systems":                                                                                                                       "0-521-84772-9",
		"Thinking Forth":                                                                                                                                          "0-9764587-0-5",
		"Time Synchronization Application in Wireless Sensor Network":                                                                                             "978-3-639-00957-6",
		"Time's Alteration: Calendar Reform in Early Modern England":                                                                                              "1-85728-622-7",
		"Turbo Codes: Principles and Applications (Kluwer International Series in Engineering & Computer Science)":                                                "0-7923-7868-7",
		"Turbulence and Structures: Chaos, Fluctuations and Helical Self-organization in Nature and Laboratory (A Volume in the INTERNATIONAL GEOPHYSICS Series)": "0-12-125740-1",
		"Under the Dome": "978-0-340-99258-6",
		"Understanding Energy: Energy, Entropy and Thermodynamics for Everyman":                   "981-02-0679-8",
		"Understanding the Linux Kernel":                                                          "0-596-00565-2",
		"User Interface Design for Programmers":                                                   "1-893115-94-1",
		"VLSI: Memory, Microprocessor and ASIC":                                                   "0-8493-1737-1",
		"Vingt mille lieues sous les mers":                                                        "978-2-01-322778-0",
		"Virtual Light":                                                                           "978-0-670-85833-0",
		"Visual Complex Analysis":                                                                 "0-19-853446-9",
		"WIG Craft and Ekranoplan: Ground Effect Craft Technology":                                "978-1-4419-0041-8",
		"What Are the Chances?: Voodoo Deaths, Office Gossip and Other Adventures in Probability": "0-8018-6941-2",
		"Without Remorse":                        "0-00-647641-4",
		"Wizard: Life and Times of Nikola Tesla": "0-8065-1960-6",
		"Zero History":                           "9780670919529"}

	// ToISBN
	for _, val := range tests {
		isbn, err := ToISBN(val)
		if err != nil {
			t.Errorf("ToISBN get %q from %q convert error %q", isbn, val, err)
		}
	}

	// ISBN10()
	for _, val := range tests {
		isbn, err := ToISBN(val)
		isbn10 := isbn.ISBN10()
		if len(isbn10) != 10 {
			t.Errorf("ISBN10 get %s from %q convert error %q", isbn10, val, err)
		}
	}

	// ISBN13()
	for _, val := range tests {
		isbn, err := ToISBN(val)
		isbn13 := isbn.ISBN13()
		if len(isbn13) != 13 {
			t.Errorf("ISBN13 get %s from %q convert error %q", isbn13, val, err)
		}
	}

}