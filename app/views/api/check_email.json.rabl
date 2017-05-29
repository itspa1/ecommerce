if @user.nil?
	node(:message){"Available"}
else
	node(:message){"This Email is already taken"}
end