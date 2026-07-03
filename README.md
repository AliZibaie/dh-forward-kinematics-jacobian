# README: DH-Based Robotics Toolbox (MATLAB)

This repository provides a set of MATLAB functions and sample scripts for computing forward kinematics and the geometric Jacobian of a serial robot manipulator using the Denavit–Hartenberg (DH) convention. The code is designed for educational and prototyping purposes and relies on MATLAB's Symbolic Math Toolbox.

## Table of Contents
- [Overview](#overview)
- [File Descriptions](#file-descriptions)
  - [`transform_matrix.m`](#transform_matrixm)
  - [`link2global.m`](#link2globalm)
  - [`JacobianMatrix.m`](#jacobianmatrixm)
  - [`sample_6R.m`](#sample_6rm)
  - [`sample_singularity.m`](#sample_singularitym)
  - [`sample_workspace.m`](#sample_workspacem)
- [Usage](#usage)
- [Examples](#examples)
- [Notes](#notes)

---

## Overview
All functions expect DH parameters in the order **[a, α, d, θ]** for each joint. The functions can handle any number of joints, as long as the number of input arguments is a multiple of four.

- **`transform_matrix`** – builds the individual 4×4 homogeneous transformation from joint *i*‑1 to joint *i*.
- **`link2global`** – multiplies a sequence of individual transforms to obtain the global pose (position and orientation) of the end‑effector.
- **`JacobianMatrix`** – computes the 6×*N* geometric Jacobian (linear and angular velocity parts) for an *N*‑joint serial chain.

The sample scripts demonstrate symbolic derivation, singularity analysis, and workspace visualisation for a 6‑DOF revolute manipulator.

---

## File Descriptions

### `transform_matrix.m`
```matlab
function [T, rotationMatrix, point] = transform_matrix(a_i_1_input, alpha_i_1_input, d_i_input, theta_i_input)
```
**Purpose:**  
Returns the homogeneous transformation matrix `T` from frame *i*‑1 to frame *i* using the standard DH parameters.  
It also outputs the rotation matrix and translation vector (point) as separate returns.

**Input:** four scalars or symbolic expressions (a, α, d, θ) for a single joint.  
**Output:** `T` (4×4), `rotationMatrix` (3×3), `point` (3×1).

---

### `link2global.m`
```matlab
function [T, rotationMatrix, point] = link2global(varargin)
```
**Purpose:**  
Computes the cumulative transformation from the base frame (frame 0) to the end‑effector frame after applying all joint transforms.  
The input is a variable‑length list of DH parameters for all joints (each joint contributes four arguments).

**Input:** `a1, α1, d1, θ1, a2, α2, d2, θ2, ...`  
**Output:** overall `T` (4×4), `rotationMatrix` (3×3), `point` (3×1) of the end‑effector.

---

### `JacobianMatrix.m`
```matlab
function [J] = JacobianMatrix(varargin)
```
**Purpose:**  
Calculates the 6‑row × *N*‑column geometric Jacobian matrix.  
For each joint *i*, the linear velocity part is `cross(z_i, (P_end - P_i))` and the angular part is `z_i`, where `z_i` is the third column of the rotation matrix from base to joint *i*, and `P_i` is the position of joint *i*.

**Input:** the same variable‑length list of DH parameters for all *N* joints.  
**Output:** symbolic Jacobian matrix `J` (size 6×*N*).

---

### `sample_6R.m`
A demonstration script that defines a specific 6‑revolute (6R) manipulator. It:
- Defines the DH parameters symbolically (e.g., `a2`, `d2`, `theta1`, …).
- Prints individual joint transforms and cumulative transforms using `link2global`.
- Computes the full Jacobian.
- Extracts Euler angles (α, β, γ) from the end‑effector rotation matrix.
- Shows that the determinant of the Jacobian is zero (the robot is always singular in that configuration – likely due to an incorrect DH assignment or a known singularity).

---

### `sample_singularity.m`
This script uses the symbolic Jacobian from the same 6R robot (with some modifications) to find singularities:
- Substitutes numeric values for the constant DH parameters (`a`, `d`).
- Computes the determinant of the Jacobian.
- Factors the determinant expression.
- Lists the factors that contain joint variables – setting each factor to zero gives a singularity condition.

---

### `sample_workspace.m`
Performs a Monte Carlo simulation to visualise the reachable workspace of the 6R robot:
- Defines joint limits (in degrees) for each joint.
- Generates 500 random joint configurations.
- For each configuration, computes the end‑effector position using `link2global`.
- Plots the resulting 3D point cloud.

---

## Usage

1. **Clone or download** all `.m` files into a single folder.
2. Ensure you have the **Symbolic Math Toolbox** installed (required for symbolic variables and simplification).
3. Run any of the sample scripts (e.g., `sample_6R`) from the MATLAB command window.

**Basic example** – compute forward kinematics for a 2‑joint arm:
```matlab
% Define DH parameters: [a, alpha, d, theta]
T_total = link2global(0, 0, 0, sym('theta1'), ...
                      1, 0, 0, sym('theta2'));
disp(T_total);
```

**Compute Jacobian** for the same 2‑joint arm:
```matlab
J = JacobianMatrix(0, 0, 0, sym('theta1'), ...
                   1, 0, 0, sym('theta2'));
```

---

## Examples

- **Symbolic forward kinematics** – `sample_6R` prints all intermediate transformations.
- **Singularity analysis** – `sample_singularity` factors the determinant to identify singular configurations.
- **Workspace visualisation** – `sample_workspace` produces a scatter plot of reachable points.

---

## Notes

- **DH parameter order** is strictly **[a, α, d, θ]** for each joint.
- All functions accept **symbolic expressions** as well as numeric values, making them suitable for both analytical and numerical studies.
- The Jacobian computed is the **geometric Jacobian** (mapping joint velocities to end‑effector spatial velocity) expressed in the base frame.
- In `sample_6R`, the determinant of the Jacobian is reported as zero. This is a consequence of the chosen DH parameters (possibly a wrist singularity or a degenerate kinematic structure). The singularity script can be used to explore which joint configurations cause this.
- The workspace script uses random sampling; increase `N` for a denser point cloud.

---

## Requirements
- MATLAB R2018b or newer (Symbolic Math Toolbox required).
- No additional toolboxes are needed.


