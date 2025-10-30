// lib/snake_ladder/question_data.dart

class QuestionSet {
  final String title;
  final List<Map<String, dynamic>> questions;

  QuestionSet({required this.title, required this.questions});
}

// ------------------------- LADDER QUESTIONS --------------------------
// These questions trigger on tiles that represent positive growth/opportunity.
final Map<int, QuestionSet> ladderQuestions = {
  // Index 21: Self Belief (Existing from previous code, corrected from 5)
  21: QuestionSet(
    title: 'Self Belief',
    questions: [
      {
        'type': 'input',
        'question': 'What does self-belief mean for you?',
      },
      {
        'type': 'input',
        'question': 'Is self-belief important to you? If yes, why. If not, why?',
      },
      {
        'type': 'mcq',
        'question':
            'Rohan is scared to ask a question in class because he thinks others will laugh. What should he do?',
        'options': [
          'Stay silent and let his doubts remain',
          'Raise his hand, ask the question, and trust that it’s okay to seek clarity',
          'Wait for someone else to ask the same question',
          'Make a joke instead of asking seriously'
        ],
        'answerIndex': 1
      }
    ],
  ),
  
  // Index 8: Kindness
  8: QuestionSet(
    title: 'Kindness',
    questions: [
      {'type': 'input', 'question': 'What does being kind look like for you?'},
      {'type': 'input', 'question': 'What value does kindness hold in your life?'},
      {
        'type': 'mcq',
        'question': 'Someone is having a hard day. What do you do?',
        'options': [
          'Ignore them because everyone has problems to deal with',
          'Offer a small act of help or a kind word, even if it’s just a little gesture',
          'Wait until they ask for help, so I don’t get involved unnecessarily',
          'Only help if others are watching, so people see how kind I am'
        ],
        'answerIndex': 1
      }
    ],
  ),
  
  // Index 5: Hope
  5: QuestionSet(
    title: 'Hope',
    questions: [
      {'type': 'input', 'question': 'What comes to your mind when you hear the word ‘Hope’?'},
      {'type': 'input', 'question': 'Is ‘hope’ relevant in today’s time? If yes, why. If not, why?'},
      {
        'type': 'mcq',
        'question': 'Things aren’t going as planned, and I feel like giving up. What can I do?',
        'options': [
          'Keep thinking about everything that went wrong and feel stuck',
          'Take small steps toward what I can control and remind myself that better days are possible',
          'Rely completely on others to solve my problems',
          'Ignore the situation and distract myself so I don’t feel anything'
        ],
        'answerIndex': 1
      }
    ],
  ),
  
  // Index 18: Self-love
  18: QuestionSet(
    title: 'Self-love',
    questions: [
      {'type': 'input', 'question': 'Describe self-love using 5 words'},
      {'type': 'input', 'question': 'What does it mean to have self-love in one\'s life?'},
      {
        'type': 'mcq',
        'question': 'Which dialogue do you think describes self-love the best?',
        'options': [
          '‘Mein apni favourite hoon’',
          '‘Jab hum apne aap ko achchi tarah samajh lete hai ... toh doosre kya samajhte hai, it doesn\'t matter ... not at all’',
          '‘Keh diya na, bas keh diya’',
          '‘Mogambo khush hua’'
        ],
        'answerIndex': 1
      }
    ],
  ),

  // Index 17: Power
  17: QuestionSet(
    title: 'Power',
    questions: [
      {'type': 'input', 'question': 'What is power according to you?'},
      {'type': 'input', 'question': 'How does the presence and/or absence of power impact a person\'s life?'},
      {
        'type': 'mcq',
        'question': 'Who would you consider to be a powerful person?',
        'options': [
          'Someone who forces others to listen to them',
          'Someone who has wealth but uses it only for themselves',
          'Someone who creates change by supporting, uplifting, and inspiring others',
          'Someone who hides their strengths and never shares them'
        ],
        'answerIndex': 2
      }
    ],
  ),
  
  // Index 15: Gratitude
  15: QuestionSet(
    title: 'Gratitude',
    questions: [
      {'type': 'input', 'question': 'If you were to write the meaning of Gratitude in a dictionary, what would you write?'},
      {'type': 'input', 'question': 'Is gratitude important for you? If yes, why. If not, why?'},
      {
        'type': 'mcq',
        'question': 'When would you say ‘Thank You’ to someone?',
        'options': [
          'Only when you want something in return',
          'When you genuinely feel grateful for their help or kindness',
          'Only if the person is older or in authority',
          'When everyone else is saying it, even if you don’t mean it'
        ],
        'answerIndex': 1
      }
    ],
  ),
  
  // Index 10: Peace
  10: QuestionSet(
    title: 'Peace',
    questions: [
      {'type': 'input', 'question': 'How would you describe peace to someone so that they could understand what it means?'},
      {'type': 'input', 'question': 'Is peace of any personal significance to you? If yes, why. If not, why?'},
      {
        'type': 'mcq',
        'question': 'What is peaceful?',
        'options': [
          'When everything is quiet around you, even if your thoughts are noisy',
          'When life gives you no problems at all',
          'When your mind and heart feel calm, even while life has its ups and downs',
          'When everyone always agrees with you and nothing changes'
        ],
        'answerIndex': 2
      }
    ],
  ),
  
  // Index 1: Strength
  1: QuestionSet(
    title: 'Strength',
    questions: [
      {'type': 'input', 'question': 'What does it mean to be strong?'},
      {'type': 'input', 'question': 'How important or unimportant is it to be strong, according to you?'},
      {
        'type': 'mcq',
        'question': 'Which statement about strength is true?',
        'options': [
          'Strength is only about muscles or physical ability',
          'Strength can be mental, emotional, social, or physical',
          'Strength means never feeling fear or sadness',
          'Strength is about always being the best at everything'
        ],
        'answerIndex': 1
      }
    ],
  ),
};

// ------------------------- SNAKE QUESTIONS --------------------------
// These questions trigger on tiles that represent setbacks or challenges.
final Map<int, QuestionSet> snakeQuestions = {
  // Index 4: Ego
  4: QuestionSet(
    title: 'Ego',
    questions: [
      {'type': 'input', 'question': 'What is the meaning of ego according to you?'},
      {'type': 'input', 'question': 'Is Ego good or bad? Why?'},
      {
        'type': 'mcq',
        'question': 'What does an egoistic person look like?',
        'options': [
          'Someone who listens carefully and values others’ opinions before making decisions',
          'Someone who always wants to be the center of attention and believes their ideas are more important than others’',
          'Someone who quietly helps others without expecting anything in return',
          'Someone who occasionally expresses their thoughts but respects everyone equally'
        ],
        'answerIndex': 1
      }
    ],
  ),

  // Index 2: Comparison
  2: QuestionSet(
    title: 'Comparison',
    questions: [
      {'type': 'input', 'question': 'Give a personal example describing your understanding of comparison.'},
      {'type': 'input', 'question': 'Do you compare yourself with others? If yes, how. If not, how?'},
      {
        'type': 'mcq',
        'question': 'Your friend always compares their social media posts to their friends’ posts and feels inadequate. What is the best approach?',
        'options': [
          'Keep scrolling and feel worse every day.',
          'Limit social media use and focus on sharing things that make them genuinely happy.',
          'Copy their friends’ posts to get the same attention.',
          'Stop posting anything ever again.'
        ],
        'answerIndex': 1
      }
    ],
  ),
  
  // Index 23: Stagnation
  23: QuestionSet(
    title: 'Stagnation',
    questions: [
      {'type': 'input', 'question': 'What is the meaning of the word ‘stagnation’ according to you?'},
      {'type': 'input', 'question': 'Is stagnation part of your life? If yes, how. If not, how?'},
      {
        'type': 'mcq',
        'question': 'If you were in a situation where you were not able to move from, for example, stuck in quick sand, what would you do to get out of it?',
        'options': [
          'Do nothing and accept/succumb to your fate',
          'Rely only and only on yourself, without taking any help, to get out without any guarantee that you will succeed',
          'Do nothing and wait only till someone comes to ‘rescue’',
          'Put in as much effort as possible by yourself and seek out help which can assist you in moving out of the given situation.'
        ],
        'answerIndex': 3
      }
    ],
  ),
  
  // Index 11: Pressure
  11: QuestionSet(
    title: 'Pressure',
    questions: [
      {'type': 'input', 'question': 'Give 3 words that are similar to pressure according to you.'},
      {'type': 'input', 'question': 'Is pressure helpful, harmful, or both? Give reasons for your choice'},
      {
        'type': 'mcq',
        'question': 'There is pressure on my bladder. What should I do?',
        'options': [
          'Keep holding it because “it’s not that urgent”',
          'Drink lots of water quickly, hoping it will somehow fix itself',
          'Go to a restroom and urinate as soon as possible to relieve the pressure',
          'Distract yourself with other activities until it goes away'
        ],
        'answerIndex': 2
      }
    ],
  ),
  
  // Index 12: Self-doubt
  12: QuestionSet(
    title: 'Self-doubt',
    questions: [
      {'type': 'input', 'question': 'What does self - doubt mean?'},
      {'type': 'input', 'question': 'Does self-doubt contribute to your life? If yes, why. If not, why not?'},
      {
        'type': 'mcq',
        'question': 'I feel self-doubt. What should I do?',
        'options': [
          'Ignore it completely and pretend I’m confident, even if I feel unsure inside',
          'Compare myself to others and feel worse about my abilities',
          'Pause, reflect on my strengths, and take small steps to build confidence',
          'Avoid trying anything new to stay “safe” and prevent failure'
        ],
        'answerIndex': 2
      }
    ],
  ),
};