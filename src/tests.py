import timeit

import matplotlib.pyplot as plt
from diffeqpy import de


def f(u,p,t):
    return -u

u0 = 0.5
tspan = (0., 1.)
prob = de.ODEProblem(f, u0, tspan)
integrator = de.init(prob, de.CVODE_BDF())
start = timeit.default_timer()
sol = de.solve(prob)
end = timeit.default_timer()
print("Time to solve ODE: ", end - start)

plt.plot(sol.t,sol.u)
plt.show()