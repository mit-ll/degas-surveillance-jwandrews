# Visual Acquisition Surveillance

A surveillance model designed for the DAA Evaluation of Guidance, Alerting, and Surveillance (DEGAS) framework. This repository contains the class, Simulink Model, and unit test for a surveillance model based on the J.W. Andrews mathematical model of air-to-air visual acquisition under daylight conditions. The original model was notably used to analyze the [1986 Aeroméxico Flight 498 midair collision](https://en.wikipedia.org/wiki/Aerom%C3%A9xico_Flight_498) over Cerritos between, a large fixed-wing multi-engine and a small fixed-wing single engine aircraft.

Starting in 2021, [MIT Lincoln Laboratory](https://www.ll.mit.edu/) and the FAA Center of Excellence for UAS Research, [ASSURE](https://www.assureuas.org/) are conducting research to enhance, update, and refine the visual acquisition model. Research includes investigating the assumptions of the model to determine if the original assumptions were overly optimistic or pessimistic about human pilot visual acquisition performance. While research is ongoing, some changes have already been made to the model. For example, the original model only considered the horizontal (left / right) field of view limitations of a cockpit; whereas the updated model considers the horizontal and vertical (up / down) field of view of a cockpit. The original model effectively assumed that probability of visual acquisition was independent of the vertical view from the cockpit.

Research is ongoing and future updates to this software are expected. This software is in the open [beta / preview stage](https://en.wikipedia.org/wiki/Software_release_life_cycle).

- [Visual Acquisition Surveillance](#visual-acquisition-surveillance)
  - [Initial Setup](#initial-setup)
    - [degas-core](#degas-core)
    - [Path](#path)
  - [Citation](#citation)
    - [Software](#software)
    - [Technical Concept](#technical-concept)
  - [Distribution Statement](#distribution-statement)

## Initial Setup

This section specifies the run order and requirements for the initial setup the repository. Other repositories in this organization are reliant upon this setup being completed.

Note that for this particular surveillance block an additional time block is needed to ensure the continuity of the prior state.  The time block needs to connect the isValid output of the Visual-Aquisition-Surveillance block to the input isValid_in signal of the same block.
![image](https://user-images.githubusercontent.com/56841143/140166527-070ef5c3-b7f2-4620-9dbe-dcc5af034568.png)


### degas-core

If you have not already, complete the initial setup associated with the [`degas-core`](https://github.com/mit-ll/degas-core) repository.

### Path

Before using DEGAS, ensure that this folder and any sub-folders are added to the MATLAB path. Directions on how to do this can be found in the Quickstart section of the DEGAS README located in the DEGAS folder.

## Citation

### Software

Please use this DOI number reference when citing the software:

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.5113902.svg)](https://doi.org/10.5281/zenodo.5113902)

### Technical Concept

For the original technical concept developed by MIT Lincoln Laboratory in the 1970-1990s, please use these citations. Note that this software was based on the implementation described in ATC-151.

<details> <summary> J. W. Andrews, “Air-to-Air Visual Acquisition Performance with Pilot Warning Instruments (PWI),” Massachusetts Institute of Technology, Lincoln Laboratory, Lexington, MA, Project Report ATC-73, Apr. 1977.</summary>
<p>

```tex
@techreport{andrewsAirtoAirVisualAcquisition1977,
  title = {Air-to-{{Air Visual Acquisition Performance}} with {{Pilot Warning Instruments}} ({{PWI}})},
  author = {Andrews, J.W.},
  year = {1977},
  month = apr,
  address = {{Lexington, MA}},
  institution = {{Massachusetts Institute of Technology, Lincoln Laboratory}},
  number = {ATC-73},
  type = {Project {{Report}}}
}
```
</p>
</details>

<details> <summary> J. W. Andrews, “Modeling of Air-to-Air Visual Acquisition,” The Lincoln Laboratory Journal, vol. 2, no. 3, 1989.</summary>
<p>

```tex
@article{andrewsModelingAirtoAirVisual1989,
  title = {Modeling of {{Air}}-to-{{Air Visual Acquisition}}},
  author = {Andrews, J.W.},
  year = {1989},
  volume = {2},
  journal = {The Lincoln Laboratory Journal},
  number = {3}
}
```
</p>
</details>

<details> <summary> J. W. Andrews, “Air-To-Air Visual Acquisition Handbook,” Massachusetts Institute of Technology, Lincoln Laboratory, Lexington, MA, Project Report ATC-151, Nov. 1991.</summary>
<p>

```tex
@techreport{andrewsAirToAirVisualAcquisition1991,
  title = {Air-{{To}}-{{Air Visual Acquisition Handbook}}},
  author = {Andrews, J.W.},
  year = {1991},
  month = nov,
  pages = {84},
  address = {{Lexington, MA}},
  institution = {{Massachusetts Institute of Technology, Lincoln Laboratory}},
  number = {ATC-151},
  type = {Project {{Report}}}
}
```
</p>
</details>

<details> <summary> J. W. Andrews, “Unalerted Air-to-Air Visual Acquisition,” Massachusetts Institute of Technology, Lincoln Laboratory, Lexington, MA, Project Report ATC-152, Nov. 1991.</summary>
<p>

```tex

@techreport{andrewsUnalertedAirtoAirVisual1991,
  title = {Unalerted {{Air}}-to-{{Air Visual Acquisition}}},
  author = {Andrews, J.W.},
  year = {Novemeber, 26, 1991},
  address = {{Lexington, MA}},
  institution = {{Massachusetts Institute of Technology, Lincoln Laboratory}},
  number = {ATC-152},
  type = {Project {{Report}}}
}
```
</p>
</details>

## Distribution Statement

DISTRIBUTION STATEMENT A. Approved for public release. Distribution is unlimited.

© 2021 Massachusetts Institute of Technology.

This material is based upon work supported by the Federal Aviation Administration (FAA) and the National Aeronautics and Space Administration (NASA) under Air Force Contract No. FA8702-15-D-0001. Any opinions, findings, conclusions or recommendations expressed in this material are those of the author(s) and do not necessarily reflect the views of the FAA or NASA.

Delivered to the U.S. Government with Unlimited Rights, as defined in DFARS Part 252.227-7013 or 7014 (Feb 2014). Notwithstanding any copyright notice, U.S. Government rights in this work are defined by DFARS 252.227-7013 or DFARS 252.227-7014 as detailed above. Use of this work other than as specifically authorized by the U.S. Government may violate any copyrights that exist in this work.

This document is derived from work done for the FAA (and possibly others), it is not the direct product of work done for the FAA. The information provided herein may include content supplied by third parties.  Although the data and information contained herein has been produced or processed from sources believed to be reliable, the Federal Aviation Administration makes no warranty, expressed or implied, regarding the accuracy, adequacy, completeness, legality, reliability or usefulness of any information, conclusions or recommendations provided herein. Distribution of the information contained herein does not constitute an endorsement or warranty of the data or information provided herein by the Federal Aviation Administration or the U.S. Department of Transportation.  Neither the Federal Aviation Administration nor the U.S. Department of Transportation shall be held liable for any improper or incorrect use of the information contained herein and assumes no responsibility for anyone’s use of the information. The Federal Aviation Administration and U.S. Department of Transportation shall not be liable for any claim for any loss, harm, or other damages arising from access to or use of data or information, including without limitation any direct, indirect, incidental, exemplary, special or consequential damages, even if advised of the possibility of such damages. The Federal Aviation Administration shall not be liable to anyone for any decision made or action taken, or not taken, in reliance on the information contained herein.
