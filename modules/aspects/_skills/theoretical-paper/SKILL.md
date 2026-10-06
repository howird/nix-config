---
name: theoretical-paper
description: "Theoretical paper"
---

Generate an overview section which provides a thorough introduction to the reader of what theoretical gap this paper aims to solve. Structure this by listing each mathematical or conceptual challenge. For each challenge, describe the theoretical approach to solving it, the core intuition or lemma that led to this approach, and any prior bounds or alternative frameworks it improves upon.
At a high level, describe the primary contribution proposed in this paper.
List all mathematical foundations required to understand this paper that are not novel to it. This includes specific inequalities, base theorems, required probability spaces, or fundamental lemmas relied upon in the proofs.
Explicitly list all mathematical assumptions made in the paper. Highlight any assumptions that are unusually strong or restrictive.
Provide perspectives or contextual literature missing from the introduction if they are significant.
Recommend related papers if and only if they contain required prerequisite mathematical knowledge; be conservative.
Structure this entire section in a jot note style, not paragraphs.
Create a detailed outline of the formal problem formulation. Include all core definitions, notation setups, and the primary objective function or mathematical model. Use latex for math.
Create a detailed outline of the Proof Architecture. Do not summarize the entire appendix, but map the logical flow of the argument. Describe how the core lemmas build up to the Main Theorem. If a lemma or step uses any equations or definitions described in the problem formulation, reference that equation and explain its role in the proof.
Create a detailed outline of the theoretical guarantees and limitations. What are the final convergence rates, sample complexities, or error bounds? Explain the tightness of these bounds, the significance of the mathematical result, and the theoretical limitations.
Create a detailed outline of the empirical validation section. Structure this by listing each of the main questions the authors aimed to answer in their experiments/results section. For each question:
Explicitly state which theoretical claim, bound, or assumption this experiment was designed to validate.
Describe the experimental setups, ablations, or specific environments used.
Explain the results and the metrics used to evaluate them.
Discuss the significance of these results: do the empirical metrics tightly align with the theoretical guarantees, or do they highlight gaps where the theory breaks down in practice?
List the empirical limitations discussed by the authors.
Structure this entire section in a jot note style.