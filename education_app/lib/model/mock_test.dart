class MockTestModel {
  final String question;
  final List<String> options;
  final String detail;
  final int correctIndex;

  MockTestModel(
      {required this.question, required this.options, required this.detail, required this.correctIndex});
}
//physics
// Physics
List<MockTestModel> mockTextPhysicsQuestions = <MockTestModel>[
  MockTestModel(
      question: 'What is the SI unit of force?',
      options: ['Joule', 'Watt', 'Newton', 'Meter'],
      detail: 'The Newton (N) is the SI unit of force.',
      correctIndex: 2),
  MockTestModel(
      question: 'Which of these is a scalar quantity?',
      options: ['Velocity', 'Force', 'Speed', 'Acceleration'],
      detail: 'Speed only has magnitude, not direction.',
      correctIndex: 2),
  MockTestModel(
      question: 'What is the law of inertia also known as?',
      options: ['Newton\'s 1st Law', 'Newton\'s 2nd Law', 'Newton\'s 3rd Law', 'Law of Universal Gravitation'],
      detail: 'Newton\'s first law describes inertia.',
      correctIndex: 0),
  MockTestModel(
      question: 'What does Ohm\'s Law relate?',
      options: ['Force, mass, acceleration', 'Voltage, current, resistance', 'Energy, mass, speed of light', 'Pressure, volume, temperature'],
      detail: 'Ohm\'s Law states V = IR (Voltage = Current x Resistance).',
      correctIndex: 1),
  MockTestModel(
      question: 'What is the unit of energy?',
      options: ['Watt', 'Newton', 'Joule', 'Hertz'],
      detail: 'The Joule (J) is the SI unit of energy.',
      correctIndex: 2),
  MockTestModel(
      question: 'Which of these is a form of energy?',
      options: ['Velocity', 'Mass', 'Kinetic', 'Force'],
      detail: 'Kinetic energy is the energy of motion.',
      correctIndex: 2),
  MockTestModel(
      question: 'What is the speed of light in a vacuum?',
      options: ['300,000 m/s', '300,000 km/s', '300,000 cm/s', '300,000 mm/s'],
      detail: 'The speed of light is approximately 300,000 km/s.',
      correctIndex: 1),
  MockTestModel(
      question: 'What is acceleration due to gravity on Earth (approximately)?',
      options: ['9.8 m/s', '9.8 m/s²', '9.8 km/s', '9.8 km/s²'],
      detail: 'The acceleration due to gravity is approximately 9.8 m/s².',
      correctIndex: 1),
  MockTestModel(
      question: 'What is the phenomenon of bending of light as it passes from one medium to another called?',
      options: ['Reflection', 'Refraction', 'Diffraction', 'Interference'],
      detail: 'The bending of light is called refraction.',
      correctIndex: 1),
  MockTestModel(
      question: 'What is the SI unit of power?',
      options: ['Joule', 'Newton', 'Watt', 'Hertz'],
      detail: 'The Watt (W) is the SI unit of power.',
      correctIndex: 2),
];

// Chemistry
List<MockTestModel> mockTextChemistryQuestions = <MockTestModel>[
  MockTestModel(
      question: 'What is the chemical symbol for water?',
      options: ['H2O', 'CO2', 'NaCl', 'O2'],
      detail: 'Water is composed of two hydrogen atoms and one oxygen atom.',
      correctIndex: 0),
  MockTestModel(
      question: 'Which element is essential for organic chemistry?',
      options: ['Oxygen', 'Nitrogen', 'Carbon', 'Hydrogen'],
      detail: 'Carbon forms the backbone of organic molecules.',
      correctIndex: 2),
  MockTestModel(
      question: 'What is the pH of a neutral solution?',
      options: ['0', '7', '14', '1'],
      detail: 'A pH of 7 indicates a neutral solution.',
      correctIndex: 1),
  MockTestModel(
      question: 'What is the process of burning a substance called?',
      options: ['Melting', 'Evaporation', 'Combustion', 'Sublimation'],
      detail: 'Combustion is a chemical process that produces heat and light.',
      correctIndex: 2),
  MockTestModel(
      question: 'Which state of matter has a definite volume but no fixed shape?',
      options: ['Solid', 'Liquid', 'Gas', 'Plasma'],
      detail: 'Liquids take the shape of their container.',
      correctIndex: 1),
  MockTestModel(
      question: 'What is the smallest unit of an element?',
      options: ['Molecule', 'Atom', 'Compound', 'Ion'],
      detail: 'An atom is the basic building block of matter.',
      correctIndex: 1),
  MockTestModel(
      question: 'What is NaCl commonly known as?',
      options: ['Sugar', 'Salt', 'Vinegar', 'Baking soda'],
      detail: 'NaCl is the chemical formula for table salt.',
      correctIndex: 1),
  MockTestModel(
      question: 'Which gas is most abundant in Earth’s atmosphere?',
      options: ['Oxygen', 'Nitrogen', 'Carbon dioxide', 'Hydrogen'],
      detail: 'Nitrogen makes up approximately 78% of the atmosphere.',
      correctIndex: 1),
  MockTestModel(
      question: 'What is the chemical formula for glucose?',
      options: ['H2O', 'CO2', 'C6H12O6', 'NaCl'],
      detail: 'Glucose is a simple sugar with the formula C6H12O6.',
      correctIndex: 2),
  MockTestModel(
      question: 'What type of bond holds atoms together in a water molecule?',
      options: ['Ionic bond', 'Covalent bond', 'Metallic bond', 'Hydrogen bond'],
      detail: 'Water molecules are held together by covalent bonds, where electrons are shared between atoms.',
      correctIndex: 1),
];
//english
List<MockTestModel> mockTextEnglishQuestions = <MockTestModel>[
  MockTestModel(
      question: 'Which of these is a synonym for "happy"?',
      options: ['Sad', 'Joyful', 'Angry', 'Tired'],
      detail:
          'Joyful means feeling or expressing great pleasure or happiness.',correctIndex: 1),
  MockTestModel(
      question: 'What is the plural of "child"?',
      options: ['Childs', 'Childes', 'Children', 'Child'],
      detail: 'The plural of child is children.',correctIndex: 1),
  MockTestModel(
      question: 'Which word is an antonym for "big"?',
      options: ['Large', 'Huge', 'Small', 'Enormous'],
      detail: 'Small is the opposite of big.',correctIndex: 1),
  MockTestModel(
      question: 'Which of these is a verb?',
      options: ['Table', 'Run', 'Slow', 'Green'],
      detail: 'Run is an action word, therefore it is a verb.',correctIndex: 1),
  MockTestModel(
      question: 'What is the past tense of "go"?',
      options: ['Gone', 'Going', 'Went', 'Goes'],
      detail: 'The past tense of go is went.',correctIndex: 1),
  MockTestModel(
      question: 'Which sentence is grammatically correct?',
      options: [
        'Me went to the store.',
        'I went to the store.',
        'I goed to the store.',
        'Me go to the store.'
      ],
      detail:
          'The correct subject pronoun is "I" and the past tense of "go" is "went".',correctIndex: 1),
  MockTestModel(
      question: 'What is a noun?',
      options: [
        'An action word',
        'A describing word',
        'A person, place, or thing',
        'A connecting word'
      ],
      detail: 'A noun represents a person, place, thing, or idea.',correctIndex: 1),
  MockTestModel(
      question: 'Which is a preposition?',
      options: ['Quickly', 'Under', 'Beautiful', 'Sing'],
      detail:
          'A preposition shows the relationship between a noun or pronoun and other words in a sentence. "Under" is a preposition of place.',correctIndex: 1),
  MockTestModel(
      question: 'What does "irregardless" mean?',
      options: ['Without regard', 'Despite', 'Regardless', 'Not important'],
      detail:
          'Irregardless is considered nonstandard; "regardless" is the correct term with the same meaning.',correctIndex: 1),
  MockTestModel(
      question: 'Which punctuation mark ends a sentence?',
      options: [',', ';', '.', '?'],
      detail: 'A period (.) ends a declarative sentence.',correctIndex: 1),
];
//Biology
List<MockTestModel> mockTextBiologyQuestions = <MockTestModel>[
  MockTestModel(
      question: 'Which organelle is the powerhouse of the cell?',
      options: ['Nucleus', 'Mitochondria', 'Ribosome', 'Chloroplast'],
      detail: 'Mitochondria produce ATP, the cell\'s main energy source.',correctIndex: 1),
  MockTestModel(
      question: 'What is the main function of red blood cells?',
      options: [
        'Fighting infection',
        'Transporting oxygen',
        'Blood clotting',
        'Digestion'
      ],
      detail: 'Red blood cells contain hemoglobin, which carries oxygen.',correctIndex: 1),
  MockTestModel(
      question: 'Which process do plants use to make food?',
      options: ['Respiration', 'Photosynthesis', 'Digestion', 'Excretion'],
      detail:
          'Photosynthesis uses sunlight, water, and CO2 to produce glucose.',correctIndex: 1),
  MockTestModel(
      question: 'What is the basic unit of heredity?',
      options: ['Cell', 'Tissue', 'Gene', 'Organ'],
      detail: 'Genes are segments of DNA that code for specific traits.',correctIndex: 1),
  MockTestModel(
      question: 'Which gas do plants release during photosynthesis?',
      options: ['Carbon dioxide', 'Nitrogen', 'Oxygen', 'Hydrogen'],
      detail: 'Oxygen is a byproduct of photosynthesis.',correctIndex: 1),
  MockTestModel(
      question: 'What is the largest organ in the human body?',
      options: ['Heart', 'Liver', 'Skin', 'Brain'],
      detail:
          'The skin covers the entire body and protects it from the environment.',correctIndex: 1),
  MockTestModel(
      question: 'Which type of tissue covers the body\'s surfaces?',
      options: ['Muscle', 'Nervous', 'Epithelial', 'Connective'],
      detail: 'Epithelial tissue forms protective barriers and linings.',correctIndex: 1),
  MockTestModel(
      question: 'What is the function of the kidneys?',
      options: [
        'Pumping blood',
        'Filtering waste',
        'Digesting food',
        'Breathing'
      ],
      detail:
          'The kidneys filter waste products from the blood and produce urine.',correctIndex: 1),
  MockTestModel(
      question: 'Which vitamin is produced by the skin in sunlight?',
      options: ['Vitamin A', 'Vitamin C', 'Vitamin D', 'Vitamin K'],
      detail:
          'Vitamin D is synthesized in the skin upon exposure to UV light.',correctIndex: 1),
  MockTestModel(
      question: 'What is the process of biological change over time called?',
      options: ['Metabolism', 'Evolution', 'Reproduction', 'Homeostasis'],
      detail:
          'Evolution is the change in heritable characteristics of biological populations over successive generations.',correctIndex: 1),
];
//Analytical Reasoning
List<MockTestModel> mockTextAnalyticalReasonQuestions = <MockTestModel>[
  MockTestModel(
      question:
          'All birds have feathers. A robin is a bird. Therefore, a robin has:',
      options: ['Wings', 'A beak', 'Feathers', 'A nest'],
      detail:
          'Since all birds have feathers, and a robin is a bird, it logically follows that a robin has feathers.',correctIndex: 1),
  MockTestModel(
      question:
          'If all cats are mammals and all mammals are animals, then all cats are:',
      options: ['Reptiles', 'Birds', 'Animals', 'Fish'],
      detail:
          'This is a deductive reasoning problem. If A is part of B, and B is part of C, then A is also part of C.',correctIndex: 1),
  MockTestModel(
      question:
          'John is taller than Mary. Mary is taller than Peter. Who is the tallest?',
      options: ['John', 'Mary', 'Peter', 'Cannot be determined'],
      detail:
          'If John is taller than Mary, and Mary is taller than Peter, then John is the tallest.',correctIndex: 1),
  MockTestModel(
      question: 'Which number comes next in the sequence: 2, 4, 6, 8, ?',
      options: ['9', '10', '11', '12'],
      detail:
          'The sequence increases by 2 each time, so the next number is 10.',correctIndex: 1),
  MockTestModel(
      question:
          'If it rains, the ground gets wet. The ground is wet. Did it rain?',
      options: ['Yes', 'No', 'Maybe', 'Certainly not'],
      detail:
          'While rain *could* cause the ground to be wet, other factors could as well (e.g., sprinklers). Therefore, the answer is maybe.',correctIndex: 1),
  MockTestModel(
      question:
          'Some fruits are sweet. Apples are fruits. Are all apples sweet?',
      options: ['Yes', 'No', 'Maybe', 'Definitely'],
      detail:
          'The statement only says *some* fruits are sweet; it doesn\'t guarantee that *all* fruits, including apples, are sweet.',correctIndex: 1),
  MockTestModel(
      question:
          'A is north of B. C is east of B. In which direction is C from A?',
      options: ['North-East', 'South-East', 'North-West', 'South-West'],
      detail: 'Visualizing this spatially, C would be to the South-East of A.',correctIndex: 1),
  MockTestModel(
      question:
          'If all squares are rectangles, but not all rectangles are squares, which is true?',
      options: [
        'All rectangles are squares',
        'Some rectangles are squares',
        'No rectangles are squares',
        'All squares are also triangles'
      ],
      detail:
          'The statement indicates that some, but not all, rectangles can be squares.',correctIndex: 1),
  MockTestModel(
      question: 'Complete the analogy: Hot is to cold as up is to:',
      options: ['High', 'Down', 'Sideways', 'Warm'],
      detail: 'Hot and cold are opposites, as are up and down.',correctIndex: 1),
  MockTestModel(
      question: 'If today is Monday, what day was it two days ago?',
      options: ['Wednesday', 'Saturday', 'Sunday', 'Friday'],
      detail:
          'Counting back two days from Monday, we have Sunday then Saturday.',correctIndex: 1),
];
