within IndustrialControlSystems.Controllers.AutoTuning;
model ATPIrelayNCmixedMode
  "PI controller with Auto Tuning algorithm - mixed continuous/discrete time version -"
  extends IndustrialControlSystems.Controllers.Interfaces.Controller(final
      useAT=true);
  import Modelica.Constants.*;
  parameter Real Kp = 5 "|Parameters| Proportional gain (initial value)" annotation(Evaluate = true);
  parameter Real Ti = 1 "|Parameters| Integral time (initial value)" annotation(Evaluate = true);
  parameter Real slope = 1 "|Auto Tuning Algorithm| Slope of the signal";
  parameter Real permOxPeriodPerc = 5
    "|Auto Tuning Algorithm| allowed % difference between period measurements";
  parameter Real pm = 45 "|Auto Tuning Algorithm| Phase Margin required";
  parameter Integer nOxMin = 3
    "|Auto Tuning Algorithm| minimum number of oscillations";
  Integer iMode;
  Real K;
  Real TI;
protected
  Real satIn;
  Real linFBout(start=0,stateSelect=StateSelect.always);
  Real CSpi;
  discrete Real CSat;
  discrete Boolean AT;
  discrete Boolean UP;
  discrete Real rPVmax;
  discrete Real rPVmin;
  discrete Real rCSmax;
  discrete Real rCSmin;
  discrete Real lastToggleUp;
  discrete Real period;
  discrete Real wox;
  discrete Real Pox;
  discrete Integer nOx;
equation
  // the sampling time must be greater than zero
  assert(Ts>0,"Ts MUST be >0 for the AutoTuning phase");

  // The PI controller is implemented with its continuous time version
  satIn    = linFBout + K*(SP-PV);
  linFBout = CSpi  - TI*der(linFBout);
  CSpi     = if ts then tr else noEvent( if AntiWindup then max(CSmin,min(CSmax,satIn)) else satIn);

  // Manage the Control Signal selection:
  // if the flag
  //  iMode == 0 PI controller
  //  iMode == 1 Auto Tuning initialisation
  //  iMode == 2 Auto Tuning is running
  if iMode==0 or iMode==1 then
     CS = CSpi + (if ts then 0 else bias);
  else
     CS = CSat;
  end if;

algorithm
  // the algorithmic section takes into accout the Auto Tuning procedure

  // parameters initialisation
  when initial() then
       K  := Kp;
       TI := Ti;
       AT := false;
  end when;

  // Turn on AT when requested
  when at_req then
       if not AT then
          AT    := true;           // set AT flag on
          iMode := 1;              // set next mode to AT init
       end if;
  end when;

  // Auto Tuning init mode
  when AT and iMode==1 and sample(0,Ts) then
       iMode        := 2;          // set next mode to AT run
       CSat         := pre(CSpi);
       UP           := false;
       period       := 0;
       wox          := 0;
       Pox          := 0;
       rPVmax       := pre(PV);
       rPVmin       := pre(PV);
       rCSmax       := CSat;
       rCSmin       := CSat;
       lastToggleUp := time;
       nOx          := 0;
  end when;

  // Auto Tuning shutdown
  when (iMode==1 or iMode==2) and not AT and sample(0,Ts) then
       iMode := 0;
       reinit(linFBout,CSat);
  end when;

  // Auto Tuning run mode
  when AT and iMode==2 and sample(0,Ts) then
        // Manage relay
        if UP==false and PV<=SP then
           UP    := true;
        end if;
        if UP==true and PV>SP then
           UP    := false;
        end if;
        if UP==true then
           CSat := CSat + slope*Ts;
        else
           CSat := CSat - slope*Ts;
        end if;

        // record relay id max and min for PV and CS
        if PV>rPVmax then
           rPVmax := PV;
        end if;
        if PV<rPVmin then
           rPVmin := PV;
        end if;
        if CSat>rCSmax then
           rCSmax := CSat;
        end if;
        if CSat<rCSmin then
           rCSmin := CSat;
        end if;

        // toggled up, compute ox data and tune if perm
        if UP==true and pre(UP)==false then
           // count and measure the period and number of oscillations
           period       := time-lastToggleUp;
           lastToggleUp := time;

           // if the number of induced oscillations is higher than the minimum
           // required number, then compute the controller parameters
           if period>0 and nOx>=nOxMin
              and abs(period-pre(period))/period < permOxPeriodPerc/100 then
              AT     := false;
              wox    := 2*Modelica.Constants.pi/period;
              Pox    := Modelica.Constants.pi^2*(rPVmax-rPVmin)/8/(rCSmax-rCSmin);
              TI     := tan(pm/180*Modelica.Constants.pi)/wox;
              K      := wox*TI/Pox/sqrt(1+(wox*TI)^2);
           end if;
           rPVmax       := PV;
           rPVmin       := PV;
           rCSmax       := CSat;
           rCSmin       := CSat;
           nOx          := nOx+1;
        end if;
  end when;
  annotation (Icon(graphics={
        Text(
          extent={{-78,-36},{78,-62}},
          lineColor={0,0,0},
          textString="mixed"),
        Text(
          extent={{-44,54},{40,32}},
          lineColor={0,0,0},
          textString="AUTO"),
        Text(
          extent={{-44,16},{42,-20}},
          lineColor={0,0,0},
          textString="PI")}),            Diagram(graphics),
    Documentation(revisions="<html>
<dl><dt>Industrial Control Systems (v 1.0.0) : April-May 2012</dt>
<dl><dt>List of revisions:</dt>
<p><ul>
<li>11 May 2012 (author: Marco Bonvini)</li>
</ul></p>
<dl><dt><b>Main Authors:</b> <br/></dt>
<dd>Marco Bonvini; &LT;<a href=\"mailto:bonvini@elet.polimi.it\">bonvini@elet.polimi.it</a>&GT;</dd>
<dd>Alberto Leva &LT;<a href=\"mailto:leva@elet.polimi.it\">leva@elet.polimi.it</a>&GT;<br/></dd>
<dd>Politecnico di Milano</dd>
<dd>Dipartimento di Elettronica e Informazione</dd>
<dd>Via Ponzio 34/5</dd>
<dd>20133 Milano - ITALIA -<br/></dd>
<dt><b>Copyright:</b> </dt>
<dd>Copyright &copy; 2010-2012, Marco Bonvini and Alberto Leva.<br/></dd>
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>.</i><br/></dd>
</dl></html>", info="<HTML>
  <h4>Description</h4>
  <p>
  Proportional + Integral controller with AutoTuning, Automatic, Tracking mode and bias signal.<br/>
  The control law is defined as
  <pre>
              1+sTi 
  CS(s) = Kp ------- (SP(s) - PV(S))
               sTi
  </pre>
  <br/><br/>
  <b>Scheme</b><br/><br/>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/PropInt.png\">
  <br/><br/>
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH >Name</TH><TH>Description</TH><TH>Conditional?</TH></TR>
  <tr>  <td>SP</td><td>Set Point</td><td>NO</td></tr>
  <tr>  <td>PV</td><td>Process Variable</td><td>NO</td></tr>
  <tr>  <td>CS</td><td>Control Signal</td><td>NO</td></tr>
  <tr>  <td>TR</td><td>Track Reference signal</td><td>YES (useTS)</td></tr>
  <tr>  <td>TS</td><td>Track Switch signal</td><td>YES (useTS)</td></tr>
  <tr>  <td>Bias</td><td>Biasing signal</td><td>YES (useBIAS)</td></tr>
  <tr>  <td>ATreq</td><td>AutoTuning request</td><td>YES (useAT)</td></tr>
  </table><br/><br/>
  The controller can have various operating conditions:
  <ul>
  <li>Automatic,</li>
  <li>Auto Tuning,</li>
  <li>and Tracking</li>
  </ul><br/>
  
  In the Automatic mode, the control output is computed with the proportional+integral control law, while in the tracking mode<br>
  it is defined by the input TR.<br/><br/>
  </p>
  <h4>Auto Tuning</h4>
  <p>
  This section presents the Modelica realisations of the fully digital of the considered autotuning methodology.

  The block inputs are the set point (SP) and the process variable (PV), plus a boolean one, a pulse on which
  initiates the autotuning procedure; the output is clearly the control signal (CS).
  The initial values for K and Ti, as well as the required phase margin pm, are provided as parameters.
  
  The autotuning procedure is composed of the following steps:
  <ul>
  <li>start with the controller in PI mode;</li>
  <li>when the AT pulse is received,</li>
        <ul>
        <li>initialise the relay plus integrator control,</li>
        <li>connect it to the process,</li>
        <li>and wait for a permanent oscillation;</li>
        </ul>
        in the quite simple procedure presented here, an oscillation is considered permanent when the 
        difference between its period and that of the previous one is less than a percent defined as parameter,
        while - for the sake of safety in the face of possible outliers - a certain number of oscillations, 
        defined as a parameter too, is counted unconditionally before proceeding;</li>
  <li>when a permanent oscillation is detected, compute its frequency (wox), and by means of the following equation
  determine the corresponding process frequency response magnitude (the phase is -90 degrees);
  <br><pre>
  Pox    := pi^2*(rPVmax-rPVmin)/8/(rCSmax-rCSmin)
  </pre>
  </li>
  <li>apply equations
  <br><pre>
  TI     := tan(pm/180*pi)/wox
  K      := tan(pm/180*pi)/(Pox*sqrt(1+(tan(pm/180*pi))^2))
  </pre>
  to tune the regulator, and finally switch back to PI mode.</li>
  </ul><br><br>
  It is worth noticing that any industrial realisation would be more articulated than those illustrated in the following.
  For example, some logic would need introducing to abort the procedure in the case of unexpected and/or possibly harmful 
  system behaviours, a confirmation should be requested to the operator in order to accept or decline the proposed
  parameters prior to updating the PI, and so forth. Such features are however omitted here since they are lengthy to
  discuss in the necessary detail, and substantially inessential for the purpose of this work.
  
  <h4>Mixed Mode</h4>
  When everything is digital, things are simple, and the only issue to care about is to correctly manage the regulator tracking
  while the relay is driving the control signal so as to achieve the required permanent oscillation. If conversely one wants to 
  represent the controller as a continuous-time system, it is necessary to suitably coordinate it with the digital procedure.

  The solution adopted here can be summarised as follows. First, implement the controller in the desired form (here, for consistence 
  with the digital case, an antiwindup PI was chosen) as differential and algebraic equations. Then, realise the autotuning procedure 
  as a digital algorithm, including the control computation during that procedure, exactly as it was in the fully digital case. 
  Finally, manage the autotuning request event by (a) setting a flag that selects the control output to be that coming from the 
  equations or the algorithm, depending on the mode, and (b) initialising the algorithm output to the last equation output. 
  Analogously, manage the autotuning termination by resetting the above flag, and reinitialising the equation-based controller state 
  to match the last algorithm output.

  The only (small) disadvantage of such a solution is that the equation-based controller stays in place during the autotuning phase. 
  However the resulting overhead is generally very limited, given the invariantly simple structure of the controller, while there is 
  a gain in terms of simplicity with respect to possible alternative solutions attempting to avoid said overhead.
  <br>
  <h4>References</h4>
  For more information please refers to the following
  <a href=\"modelica://IndustrialControlSystems/help/refs/EffHybPITuning.pdf\">paper</a>:<br><br>
  <b>Efficient hybrid simulation of autotuning PI controllers</b><br>
  Alberto Leva, Marco Bonvini<br>
  8th Modelica Conference, Dresden, Germany<br>
  march 20-22, 2011<br>
  </p>
    </HTML>"));
end ATPIrelayNCmixedMode;
