checks = {}

function checks.typeError(name, value)
    error("variable "..name.." is "..type(value))
end

function checks.requireNotNil(name, value)
    if (value == nil) then
        checks.typeError(name, value)
    end
end

function checks.requireType(name, value, ...)
    local valueType = type(value)
    for _,expectedType in ipairs({...}) do
        if (valueType == expectedType) then
            return value
        end
    end
    checks.typeError(name, value)
end
