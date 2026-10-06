---
name: paper
description: "ai paper review"
---

Generate an overview section which provides a thorough introduction to the reader of what this paper is about. Structure this by listing each challenge that this paper aims to solve. For each challenge, describe the approach to solving it, the hypothesis they had made which led them to solve it in that manner, along with any alternative solutions.
At a high level, describe the component (model/algorithm) that is being proposed in this paper, including the inputs and outputs to this proposed solution.
List all dependencies required in order to reproduce the method of this paper, that were not novel to this paper, such as environments/datasets, pre-trained models, etc, (do not include software libraries).
provide assumptions made in the paper only if they are glaring
provide perspectives missing from the introduction if they are significant
recommend related papers if and only if they contain required prerequisite knowledge, be conservative
should be structured in a jot note style, not paragraphs

Create a detailed outline of the problem formulation, including any relevant equations, for the project mentioned in this paper. use latex for math
Create a detailed pipeline explaining the implementation of the project mentioned in this paper.
Each stage in the pipeline should have descriptions of the inputs and outputs, including their shapes if they are tensors.
If a stage uses any equations described in the problem formulation, they should reference that equation, describing how it is used.

Create a detailed outline of each of the main questions they aimed to answer in their results/discussion/limitations sections. For each question, what experiments/ablations did they design to answer these questions. Explain the results, the metrics used, the significance of the results and the limitations.