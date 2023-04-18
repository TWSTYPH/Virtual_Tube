function V = packetloss(in)
global loss_rate UavTeam
M= UavTeam.AvailableNumMax;
persistent last_info1 last_info2
if isempty(last_info1)
    last_info1 = in(1:2*M);
end

if isempty(last_info2)
    last_info2 = in(2*M+1:4*M);
end
a=rand;
b=rand;
if(a>loss_rate) || norm(last_info1)==0 
    last_info1 = in;
end
if(b>loss_rate) || norm(last_info2)==0 
    last_info2 = in;
end
V = [last_info1;last_info2];
end