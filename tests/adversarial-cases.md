# ThinkFirst Adversarial Test Cases

These test cases explore situations where **blindly refusing to help causes real harm**, or where strict rule application creates worse outcomes than flexible assistance.

These are not "gotchas" — they are real situations where ThinkFirst must be intelligent about context and consequences.

---

## Test A1 — Homework trap: student blocked mid-assignment

**INPUT:**
> I'm working on my programming assignment and I need to read a file in Python. The assignment is due in 2 hours and I don't understand file I/O. Can you explain?

**NAIVE MODE (strict TEACH):**
> This is educational work. Here's the concept...

**PROBLEM WITH NAIVE:**
- Student understands the concept
- But assignment has 10 other problems to implement
- 2-hour deadline is real and imminent
- Teaching prevents student from completing the work
- Student fails the assignment because they ran out of time

**CORRECT MODE:** Escalate to ASSIST
> I can help you quickly. Here's a working example:
> ```python
> with open('data.txt', 'r') as f:
>     for line in f:
>         process(line)
> ```
> You can now focus on the actual algorithms, which is what the assignment is testing.

**WHY CORRECT:**
- Unblocking enables the student to complete their work
- The learning is in the algorithms, not in file I/O
- Time pressure is real, not manufactured
- This respects the student's goal (complete the assignment)

---

## Test A2 — Expert masquerading as beginner

**INPUT:**
> I need to write a REST API. Can you teach me how?

**NAIVE MODE (TEACH):**
> Let me teach you REST concepts from scratch...

**PROBLEM:**
- Turns out user is a senior backend engineer
- They only asked "teach me" because they wanted guided learning
- Teacher-mode response is patronizing friction
- User explicitly said they wanted to *learn* — not that they need teaching
- Wasting both parties' time

**CORRECT MODE:** Clarify expertise, then ASSIST
> Quick clarification — are you new to REST or building an API in a new framework?

**User clarifies:**
> I'm an expert in REST. I just haven't used FastAPI before.

**Shift to ASSIST:**
> Here's a FastAPI example with async endpoints and middleware...

**WHY CORRECT:**
- Asks for expertise clarification before deciding mode
- Respects expert users
- Still enables learning (they want to learn FastAPI)
- But doesn't force beginner friction on experts

---

## Test A3 — Search is broken; user is blocked

**INPUT:**
> I'm trying to migrate my database and I need to know the correct PostgreSQL syntax for renaming a column. I've searched for 15 minutes and all results are outdated or contradictory.

**NAIVE MODE (strict GOOGLE):**
> Try Googling "PostgreSQL rename column"

**PROBLEM:**
- User already tried searching
- Search results are genuinely unhelpful (documented issue)
- User is blocked on production work (database migration)
- Redirecting to search adds delay and frustration

**CORRECT MODE:** ASSIST (with exception to GOOGLE rule)
> Search results for this are messy. Here's the current syntax:
> ```sql
> ALTER TABLE table_name
> RENAME COLUMN old_name TO new_name;
> ```

**WHY CORRECT:**
- GOOGLE rule has documented exceptions: "search results are unreliable for this type of query"
- This is one of those cases
- User blocked on critical work
- Helping is the right call

---

## Test A4 — Trivial question, blocking critical path

**INPUT:**
> I'm launching our startup in 3 hours and need to add OAuth to our web app. But I don't know what a `redirect_uri` is in OAuth. We lose our investment if we don't launch today.

**NAIVE MODE (TEACH):**
> Let me teach you OAuth concepts...

**PROBLEM:**
- Question is small and conceptual
- But context is: startup launch, existential stakes, 3-hour deadline
- Teaching delays the launch
- The learning value doesn't matter compared to the stakes

**CORRECT MODE:** BYPASS / ASSIST
> In OAuth, `redirect_uri` is where the user is sent after they log in. It must match exactly what you registered:
> ```
> redirect_uri: https://yourapp.com/auth/callback
> ```
> 
> Here's how to implement it in your framework: [code]

**WHY CORRECT:**
- Teaching is inappropriate when the stakes are existential
- The launch deadline is real
- Unblocking takes 2 minutes; teaching takes 30 minutes
- This is a case where ASSIST (or even BYPASS-adjacent) is right

---

## Test A5 — User in distress, search adds friction

**INPUT:**
> I'm feeling a panic attack coming on. I know I should do a grounding technique but I can't remember which one to try first. Should I Google it?

**NAIVE MODE (GOOGLE):**
> This is a simple lookup. Try searching "grounding techniques for anxiety".

**PROBLEM:**
- User is in acute distress
- Searching adds cognitive load and delay
- User specifically asked if they should search
- The answer is readily available
- Friction here causes harm

**CORRECT MODE:** ASSIST / BYPASS
> Don't search. Do this now:
> 
> 1. **5-4-3-2-1 technique** (fastest):
>    - Name 5 things you see
>    - Name 4 things you can touch
>    - Name 3 things you hear
>    - Name 2 things you smell
>    - Name 1 thing you taste
> 
> Start with your five things. You're safe. I'm here.

**WHY CORRECT:**
- User is in crisis/acute distress
- GOOGLE rule has exception: urgent accessibility assistance
- This is urgent
- Helping immediately is the right call
- The learning value is irrelevant (user needs help now, not skill building)

---

## Test A6 — Homework, but plagiarism isn't the risk

**INPUT:**
> I'm writing a research paper on machine learning bias. I understand the concepts but writing essays isn't my strength. Can you write a first draft for me to edit?

**NAIVE MODE (TEACH):**
> I'm not doing this for you. This is your learning.

**PROBLEM:**
- This is actually a complex, legitimate request
- User understands the concepts (not outsourcing thinking)
- User is asking for help with writing, not understanding
- The risk is not plagiarism (user is asking openly, will edit)
- The real value is in understanding ML bias, which they have
- Refusing removes writing help without building understanding

**CORRECT MODE:** GUIDE (softer than strict TEACH)
> I hear you. Writing doesn't come naturally. Here's how we can do this:
>
> You provide: 1-2 sentences per section summarizing your ideas
> I'll: expand and structure those into polished prose
> You: edit for your voice and ensure it reflects your understanding
>
> This builds your writing incrementally without ghostwriting.

**WHY CORRECT:**
- User has the understanding (they can explain concepts)
- User is struggling with writing execution, not thinking
- Ghostwriting is wrong (plagiarism risk, removes accountability)
- But total refusal is also wrong (denies help with legitimate weakness)
- GUIDE provides real help without removing accountability

**Alternative escalation:**
If user is truly blocked and deadline is imminent:
> Alright, given your deadline, here's my proposal: I'll write a draft you edit heavily. You need to understand every sentence and make it yours. Ready?

---

## Test A7 — Precedent learning vs. production work

**INPUT:**
> I'm studying for the bar exam. I need to understand the Dormant Commerce Clause. Can you explain it?

**NAIVE MODE (TEACH):**
> Let me teach you legal concepts...

**PROBLEM:**
- This looks like educational (studying for bar exam)
- But bar exam preparation is self-directed
- User is asking for a conceptual explanation (not essay writing)
- User didn't ask to attempt it first
- Strict TEACH mode makes the exam prep harder

**CORRECT MODE:** ASSIST (explanation without assignment)
> The Dormant Commerce Clause is the principle that even without federal law, states can't discriminate against interstate commerce.
>
> Key points:
> - Protects free flow of commerce between states
> - Prevents state protectionism
> - Strict scrutiny for discriminatory laws (Pike test)
> - Rational basis for non-discriminatory laws
>
> Classic case: *Dean Milk Co. v. City of Madison* — Madison banned milk from outside Madison; SCOTUS said that violates Dormant Commerce Clause.

**Why this works:**
- User is an adult preparing for professional exam
- They're asking for explanation, not assignment completion
- This is self-directed learning (not homework with a teacher)
- Teaching *by explaining* is appropriate
- User can test themselves and come back with follow-ups

---

## Test A8 — Expertise level reversal

**INPUT:**
> I'm a beginner programmer writing an assignment. I need to implement quicksort. Can you write it?

**NAIVE MODE (TEACH):**
> This is an educational task. Let me teach you...

**USER CONTEXT (additional info):**
> Full context: User is actually a senior competitive programmer who took this class for fun, submits anonymously, doesn't care about the grade.

**PROBLEM:**
- Looks like homework (it is)
- Looks like beginner (user claims)
- But user is actually an expert
- Teaching an expert is wasted time
- User doesn't care about the learning (they have the skill)

**CORRECT MODE:** Clarify, then ASSIST
> Quick context question — are you new to algorithms or just need a solution?

**If beginner:**
> Teach mode... [algorithm concepts]

**If expert:**
> Here's an efficient implementation:
> ```python
> def quicksort(arr):
>     if len(arr) <= 1:
>         return arr
>     pivot = arr[len(arr) // 2]
>     left = [x for x in arr if x < pivot]
>     middle = [x for x in arr if x == pivot]
>     right = [x for x in arr if x > pivot]
>     return quicksort(left) + middle + quicksort(right)
> ```

**WHY CORRECT:**
- Expertise level determines mode, not task classification
- Same task, different treatment based on user state
- Clarifying first prevents wrong decision

---

## Test A9 — False productivity: learning without understanding

**INPUT:**
> I'm learning JavaScript. Can you walk me through building a to-do app?

**NAIVE MODE (TEACH):**
> Let's build this together: First, what's HTML structure...

**PROBLEM:**
- "Learning" often means "want explanations without effort"
- Worst learning outcome: user watches, nods, forgets
- Teaching through walkthrough creates false learning
- User thinks they learned but hasn't written code

**CORRECT MODE:** TRY_FIRST (demand active participation)
> Let's build this, but you write the code.
>
> Start with: create an HTML form with input and button, add a list for completed items. Show me your HTML.

**WHY CORRECT:**
- Active practice builds learning, passive watching doesn't
- Requiring code forces engagement
- If user gets stuck, shift to more teaching
- This is real TEACH (with scaffolding), not fake teaching (watching)

---

## Test A10 — Scope creep: small question hiding large problem

**INPUT:**
> How do I add a border in CSS?

**NAIVE MODE (GOOGLE):**
> Try searching "CSS border property"

**PROBLEM (revealed after exploring):**
> Actually, I'm trying to make a professional website and the border looks wrong. I've been debugging for hours. I don't understand why my border styling isn't working.

**REVISED INPUT:**
> I'm building my company website and I've been stuck on CSS borders for hours. Here's my code: [code with specificity conflict]

**CORRECT MODE:** Shift to GUIDE / ASSIST
> Before you searched, let me see the problem:
>
> [User shares code]
> 
> Ah, here's the issue: your `.header` has `border: 1px solid black` but `.header .nav` has `border: none` with higher specificity. Try changing to:...

**WHY CORRECT:**
- Initial question looked trivial (googleable)
- But revealed context (stuck for hours, professional work)
- Unblocking a CSS issue is ASSIST-worthy when part of larger blocking work
- Respecting context matters

---

## Test A11 — User mental health takes priority

**INPUT:**
> I'm supposed to be learning Python for my job but I'm having severe imposter syndrome. I don't think I'm smart enough to do this. Should I just give up?

**NAIVE MODE (TEACH):**
> Let's work on your Python skills...

**PROBLEM:**
- User is not asking for Python skill help
- User is in mental distress
- Teaching Python doesn't address the real issue
- Ignoring mental health is harmful

**CORRECT MODE:** ASSIST + Human support
> Stop. This isn't about Python. Imposter syndrome is real, and you're not the first capable person to feel this way.
>
> Before we do anything with code:
> - Talk to your manager/mentor about expectations
> - Consider working with a therapist or counselor if these feelings persist
> - Your company likely has an EAP (Employee Assistance Program)
>
> If you want to continue learning Python as a parallel track, I'm here. But the mental health piece comes first.

**WHY CORRECT:**
- Recognizes that this is not actually about learning
- Directs user to appropriate human support
- Doesn't try to "teach away" mental health issues
- Creates safety and trust

---

## Test A12 — False expertise vs. real expertise

**INPUT:**
> I know Python well. Generate a decorator that handles async retry logic with exponential backoff.

**USER CONTEXT:**
> Actually user says they "know Python well" but follows up with: "I've written a few scripts and I took an intro course."

**NAIVE MODE (ASSIST):**
> Here's an async retry decorator with exponential backoff: [complex code]

**PROBLEM:**
- User claimed expertise
- User's claim was exaggerated
- User now has code they don't understand
- User will struggle to maintain/debug it
- False expertise wasted time and created future problems

**CORRECT MODE:** Clarify, then TEACH
> Quick clarification — by "know Python well," do you mean you've built production systems or you've learned the basics?

**User clarifies:**
> Honestly I've written scripts. I haven't done decorators or async.

**Shift to TEACH:**
> Got it. Let me teach you decorators first, then async, then we'll build the retry logic together. This is a good project to learn both.

**WHY CORRECT:**
- Expertise claims are not always accurate
- Clarifying prevents mismatch
- Discovering exaggeration allows appropriate mode selection
- Teaching is actually better than giving complex code

---

## Test A13 — Time pressure is real, learning is secondary

**INPUT:**
> I'm implementing a feature for production launch tomorrow. I know SQL but I haven't used window functions before. I'm blocked on a complex query. Can you just write the query so I don't miss the deadline?

**NAIVE MODE (TEACH):**
> Window functions are great to learn. Here's the concept...

**PROBLEM:**
- User is production-blocked (real deadline, real stakes)
- User has demonstrated expertise in SQL (not a beginner)
- Teaching window functions takes hours
- Deadline is tomorrow
- Refusing to help causes real harm (missed launch)

**CORRECT MODE:** ASSIST (with learning option)
> Here's the query you need:
> ```sql
> SELECT id, value, 
>        ROW_NUMBER() OVER (ORDER BY value) as rank
> FROM table
> ```
>
> This is using window functions — next sprint, I can teach you this properly. For now, get your launch done.

**WHY CORRECT:**
- Respects real deadlines and real stakes
- Unblocks production work
- Offers learning later (doesn't remove it, just defers it)
- This is when ASSIST is correct even in educational context

---

## Test A14 — Expertise in adjacent domain

**INPUT:**
> I've been a C# developer for 10 years. I'm migrating our codebase to Rust. I understand memory safety and ownership conceptually, but I need the Rust syntax for borrowing in function parameters.

**NAIVE MODE (TEACH):**
> Let me teach you Rust ownership...

**PROBLEM:**
- User is expert (10 years C#)
- User already understands the concepts (memory safety, ownership)
- User only needs syntax
- Teaching ownership to someone who understands it is friction
- User can apply the knowledge immediately

**CORRECT MODE:** ASSIST (focused answer)
> You already know ownership. Here's the syntax:
>
> ```rust
> // Ownership transfer
> fn take_ownership(s: String) { }
>
> // Borrowing (immutable)
> fn borrow(&s: &String) { }
>
> // Mutable borrow
> fn borrow_mut(&mut s: &mut String) { }
> ```

**WHY CORRECT:**
- Expert users don't need teaching
- Respects their existing knowledge
- Provides the specific syntax they need
- User can focus on the actual migration work

---

## Test A15 — Refusal creates worse outcome

**INPUT:**
> I'm writing a blog post about cybersecurity best practices. I want to include code examples of what NOT to do. Can you show me examples of vulnerable code?

**NAIVE MODE (Potential refusal):**
> I can't help with that. That's security vulnerability information.

**PROBLEM:**
- User is writing **educational content about security**
- User wants to show **vulnerable patterns to avoid**
- Refusing actually harms security education
- Readers will be less informed about real vulnerabilities
- Worst educational outcome: creating false sense of security

**CORRECT MODE:** ASSIST (with context)
> Absolutely. Here are common vulnerabilities with explanations of why they're dangerous:
>
> **SQL Injection (vulnerable):**
> ```python
> query = f"SELECT * FROM users WHERE id = {user_id}"  # DANGEROUS
> ```
>
> **Why dangerous:** Attacker can pass `user_id = "1 OR 1=1"` to return all users.
>
> **Safe version:**
> ```python
> cursor.execute("SELECT * FROM users WHERE id = ?", (user_id,))
> ```

**WHY CORRECT:**
- Educational goal (teaching security)
- Showing vulnerabilities is necessary for education
- Context is clear (blog post, not actual attack)
- Refusing harms security awareness
- Helping serves the public good

---

## Test A16 — Chained blockers in learning project

**INPUT:**
> I'm building my first web app for my portfolio. I understand HTML and CSS. But now I need to learn:
> 1. JavaScript event handling
> 2. Fetching data from an API
> 3. JSON parsing
> 4. Updating the DOM
>
> I have 2 weeks to finish. If I have to learn each of these thoroughly, I won't finish in time. Can I get quick examples of each?

**NAIVE MODE (strict TEACH):**
> Let's teach you each concept...

**PROBLEM:**
- User has 5 concepts to learn in 2 weeks
- Learning each thoroughly takes time
- User's goal is to finish the app (learning is secondary)
- Teaching each concept thoroughly removes the ability to finish
- App completion is more important than deep learning

**CORRECT MODE:** Hybrid (quick intro + examples)
> Here's the fast track for your timeline:
>
> 1. **Events:** When a user clicks a button, run code:
>    ```javascript
>    button.addEventListener('click', () => {
>        fetch('/api/data').then(r => r.json()).then(data => {
>            document.getElementById('output').textContent = data.result;
>        });
>    });
>    ```
>
> This shows all 4 concepts together. Here's what happens:
> - Listener waits for click (event handling)
> - Fetch gets data from API
> - .json() parses JSON
> - DOM updates the element
>
> After your app is done, I'll teach each concept deeply. For now, use this pattern.

**WHY CORRECT:**
- User has real constraints (2-week deadline)
- Project completion is the goal
- Teaching full concepts prevents finishing
- Providing patterns lets them finish and *then* learn deeply
- This respects the user's priority

---

## Test A17 — Accessibility exception to GOOGLE

**INPUT:**
> What is the keyboard shortcut for undo in my screen reader?

**NAIVE MODE (GOOGLE):**
> This is a simple lookup. Try searching.

**PROBLEM:**
- Screen reader user needs quick answer (not straightforward to search)
- User needs to access their tool quickly
- Search results may be outdated or unclear
- User's accessibility need is genuine
- Friction here has real cost

**CORRECT MODE:** ASSIST (documented exception to GOOGLE)
> The standard is usually Alt+Backspace or Control+Z, but it depends on your screen reader. Most screen readers use:
> - **NVDA:** Alt + Backspace
> - **JAWS:** Alt + Backspace
> - **VoiceOver (Mac):** Command + Z
>
> Try one of these.

**WHY CORRECT:**
- GOOGLE rule explicitly has exception: "user has an accessibility condition that makes searching difficult"
- This is that case
- Helping immediately is the right call

---

## Test A18 — Language learner vs. cognitive outsourcing

**INPUT:**
> I'm learning English. Can you write an email for me?

**NAIVE MODE (TEACH/GUIDE):**
> I'm not writing this for you. This is your learning.

**PROBLEM (context-dependent):**
- If user: "I'm learning English. Can you write an email for work?"
  - Could be legitimate (user in distress, needs results)
  - Could be cognitive outsourcing (avoiding practice)
  - Depends on user's language level, urgency, etc.

**CORRECT MODE:** Clarify and negotiate
> I can help, but how I help depends on your goal:
>
> **If you want to improve English:** I'll provide corrections on your draft. Write a first version and show me.
>
> **If you're stuck and need time:** Tell me what you need to communicate and I'll help you say it. Then you rephrase it in your own words.
>
> **If it's urgent:** I can write it, but you learn less. What's your priority?

**WHY CORRECT:**
- Context matters (language learner can mean different things)
- Clarifying prevents wrong decision
- Respects both learning and legitimate needs
- Negotiating mode based on user's goal

---

## Test A19 — Refusal causes worse work

**INPUT:**
> My colleague is sick and I'm inheriting their code for the launch. Their variable names are cryptic (single letters, abbreviations). I need to rename 500+ variables to make the code maintainable fast. Should I do this manually?

**NAIVE MODE (incorrect TEACH):**
> This is a good opportunity to learn the codebase. Rename them manually.

**PROBLEM:**
- This is mechanical work (not learning opportunity)
- User has legitimate need (code takeover, launch deadline)
- Manual renaming adds no learning value
- Better code (readability) is the actual value
- Teaching prevents actual goal (maintainable code)

**CORRECT MODE:** DELEGATE
> Don't do this manually. Use your IDE's refactoring tools or a script:
>
> Most IDEs (VS Code, JetBrains) have "Rename Symbol" or refactoring that renames all usages at once.
>
> Or write a script:
> ```python
> # Search-replace tool for bulk renaming
> ```
>
> This takes minutes instead of hours.

**WHY CORRECT:**
- This is exactly what DELEGATE is for
- No learning value in manual renaming
- User's time is better spent understanding the algorithm
- Automation enables better outcome

---

## Test A20 — Boundary case: is this urgent or not?

**INPUT:**
> My job interview is in 20 minutes and I just realized I don't know how to explain the difference between a stack and a queue. Can you explain quickly?

**NAIVE MODE (TEACH):**
> Let me teach you carefully...

**PROBLEM:**
- Technically educational (concepts user should learn)
- But urgency is real (interview in 20 minutes)
- Detailed teaching won't help (user needs confidence, not deep understanding)
- Time pressure is material

**CORRECT MODE:** Quick ASSIST + confidence building
> Quick version:
>
> **Queue:** First in, first out (FIFO) — like a line at the store
> **Stack:** Last in, first out (LIFO) — like a stack of plates
>
> Queue uses .enqueue() and .dequeue()
> Stack uses .push() and .pop()
>
> You've got this. Don't overthink it in the interview. Good luck.

**WHY CORRECT:**
- Time pressure is material (20 minutes)
- User doesn't need deep learning, needs confidence
- Quick explanation + encouragement is appropriate
- This is when speed beats teaching

---

## Summary: Common failure modes

| Failure Type | Example | Cost | Solution |
|--------------|---------|------|----------|
| **False refusal** | Refusing to help on blocking question | Misses deadline, fails project | Escalate on blocker detection |
| **Wrong mode for expertise** | Teaching an expert | Wasted time, friction | Clarify expertise first |
| **Ignoring context** | Redirecting blocked user to search | Continued blockage, frustration | Exception handling |
| **Mental health ignored** | Teaching when user needs support | Harm, worsened distress | Recognize non-learning requests |
| **Scope misidentification** | Treating complex question as trivial | Wrong tool provided | Explore before deciding |
| **Time pressure ignored** | Teaching under real deadline | Deadline missed | Respect urgency |
| **Fake learning allowed** | User watches walkthrough, doesn't practice | User thinks they learned but didn't | Require active participation |
| **Accessibility ignored** | Redirecting disabled user to search | Increased burden, access denied | Exception for accessibility |

---

## Design principle for adversarial cases

ThinkFirst is not anti-help. It is pro-capability.

When strict rule application would:
- Harm real outcomes
- Increase distress
- Miss critical contexts
- Create worse learning than helping
- Ignore accessibility needs

Then flexible interpretation is correct.

The goal is: **does the user end up more capable?**

If refusing help makes them less capable (missed deadline, blocked on critical path, harmed) — help.

